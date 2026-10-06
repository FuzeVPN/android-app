import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory
import org.gradle.api.artifacts.dsl.LockMode
import org.gradle.api.artifacts.result.UnresolvedDependencyResult

allprojects {
    // Keep lockfiles in the application checkout, including the Flutter plugin
    // project whose source lives outside it in the Pub cache.
    // The approved local AAR and the debug Maven fallback have distinct graphs.
    val dependencyMode = if (name == "app") {
        if (providers.gradleProperty("fuzevpn.usePatchedWireGuardAar")
                .orElse("false").get().equals("true", ignoreCase = true)) "-patched" else "-maven"
    } else ""
    dependencyLocking {
        lockAllConfigurations()
        // Flutter selects engine artifacts per --target-platform. Their exact
        // SDK revision and bytes remain pinned by verification metadata; locking
        // the optional ABI modules would require every build to include x86_64.
        ignoredDependencies.add("io.flutter:*")
        lockMode = LockMode.STRICT
        lockFile = rootProject.layout.projectDirectory.file("gradle/dependency-locks/$name$dependencyMode.lockfile")
    }

    tasks.register("resolveLockedDependencyGraphs") {
        group = "verification"
        description = "Resolve every dependency graph for an explicit lock update"
        doLast {
            configurations.filter { it.isCanBeResolved }.forEach { configuration ->
                // Resolve the graph only: AGP secondary artifact variants need
                // the artifact attributes supplied by their actual compile tasks.
                val components = configuration.incoming.resolutionResult.allComponents
                val unresolved = configuration.incoming.resolutionResult.allDependencies
                    .filterIsInstance<UnresolvedDependencyResult>()
                check(unresolved.isEmpty()) {
                    "Cannot lock ${project.path}:${configuration.name}: ${unresolved.joinToString { it.failure.message.orEmpty() }}"
                }
                logger.lifecycle("Locked ${project.path}:${configuration.name}: ${components.size} components")
            }
        }
    }

    repositories {
        exclusiveContent {
            forRepository { mavenCentral() }
            filter { includeGroup("org.json") }
        }
        google()
        mavenCentral()
    }
}

// Resolve before assigning: keeping this as a Provider that refers back to
// rootProject.layout.buildDirectory creates a cycle under Gradle 9.5.
val sharedBuildDirectory: Directory =
    rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(sharedBuildDirectory)

subprojects {
    layout.buildDirectory.value(sharedBuildDirectory.dir(project.name))

    // AGP 9.3's CommentDetector crashes before producing a report when it
    // scans url_launcher_android's Java source on JDK 17. Keep lint enabled
    // for the application and every other dependency; only skip that broken
    // third-party *analysis* task until its upstream combination is fixed.
    if (name == "url_launcher_android") {
        // This plugin's own AGP 8.13 lint task fails inside AGP's
        // CommentDetector before it can report anything, due to a JDK 17
        // linkage error. It is a non-app, transitive UI-link dependency; skip
        // only its broken lint work, while application lint remains enabled.
        tasks.matching { it.name.startsWith("lint") }.configureEach {
            enabled = false
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
