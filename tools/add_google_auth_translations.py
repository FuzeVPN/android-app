"""Locally authored UI copy for explicit Android Google authentication."""
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1]
KEYS = '''continue or title settingUp country profileDescription claimDescription
linkTitle linkDescription password linkAccount requestEmail emailInstructions
emailCode confirmEmail restart resume unavailable expired conflict error uncertain
cancelFailed cancelled selecting verifying emailUnavailable emailSent rateLimited
invalidPassword invalidCode accountChanged invalidResponse invalidRegistration
consentRequired challengeRequired challengeUnavailable'''.split()

TEXTS = {
'en': '''Continue with Google
or
Your FuzeVPN account
Finish creating your account
Country of residence
Choose your country and review the two documents to create your FuzeVPN account.
Link your guest account to Google. Your subscription and device stay attached to this account.
Link Google to FuzeVPN
Confirm access to your existing FuzeVPN account. This step does not ask for your Google password.
FuzeVPN password
Confirm the link
Send me a confirmation email
Open the FuzeVPN email and enter the confirmation code.
Email confirmation code
Confirm the code
Choose another Google account
Check this attempt
Google sign-in is unavailable. You can use email and password.
This attempt has expired. Cancel it and start again.
This Google account is already linked elsewhere. Your current account and subscription are kept.
Google sign-in failed. Try again; your current access is kept.
The result could not be confirmed. Check this attempt or cancel it before starting again.
Cancellation could not be confirmed. Try cancelling again before leaving this screen.
Google sign-in cancelled.
Choose your Google account…
Checking your account…
The confirmation email could not be sent. Try again later.
Confirmation email sent. Check your inbox.
Please wait before trying again.
The FuzeVPN password is incorrect. Your current account is kept.
The confirmation code is invalid or expired.
Your session has changed. Cancel this attempt before starting again.
The response could not be validated. Your current access is kept.
Check your country and both consents.
Choose your country and accept both documents to continue.
An additional security check is required. Your current access is kept.
The security check is unavailable. Try again later.''',
'fr': '''Continuer avec Google
ou
Votre compte FuzeVPN
Finalisez votre compte
Pays de résidence
Choisissez votre pays et consultez les deux documents pour créer votre compte FuzeVPN.
Rattachez votre compte invité à Google. Votre abonnement et votre appareil restent associés à ce compte.
Associer Google à FuzeVPN
Confirmez l’accès à votre compte FuzeVPN existant. Cette étape ne demande pas votre mot de passe Google.
Mot de passe FuzeVPN
Confirmer l’association
Recevoir un e-mail de confirmation
Ouvrez l’e-mail de FuzeVPN et saisissez le code de confirmation.
Code de confirmation par e-mail
Confirmer le code
Choisir un autre compte Google
Vérifier cette tentative
La connexion Google est indisponible. Vous pouvez utiliser votre e-mail et votre mot de passe.
Cette tentative a expiré. Annulez-la puis recommencez.
Ce compte Google est déjà associé ailleurs. Votre compte et votre abonnement actuels sont conservés.
La connexion Google a échoué. Réessayez ; votre accès actuel est conservé.
Le résultat n’a pas pu être confirmé. Vérifiez cette tentative ou annulez-la avant de recommencer.
L’annulation n’a pas pu être confirmée. Réessayez d’annuler avant de quitter cet écran.
Connexion Google annulée.
Choisissez votre compte Google…
Vérification de votre compte…
L’e-mail de confirmation n’a pas pu être envoyé. Réessayez plus tard.
E-mail de confirmation envoyé. Consultez votre messagerie.
Veuillez patienter avant de réessayer.
Le mot de passe FuzeVPN est incorrect. Votre compte actuel est conservé.
Le code de confirmation est invalide ou expiré.
La session a changé. Annulez cette tentative avant de recommencer.
Impossible de valider la réponse. Votre accès actuel est conservé.
Vérifiez le pays et les consentements.
Choisissez votre pays et acceptez les deux documents pour continuer.
Une vérification de sécurité supplémentaire est requise. Votre accès actuel est conservé.
La vérification de sécurité est indisponible. Réessayez plus tard.''',
'es': '''Continuar con Google
o
Tu cuenta FuzeVPN
Completa tu cuenta
País de residencia
Elige tu país y revisa los dos documentos para crear tu cuenta FuzeVPN.
Vincula tu cuenta de invitado con Google. Tu suscripción y dispositivo seguirán asociados a esta cuenta.
Vincular Google con FuzeVPN
Confirma el acceso a tu cuenta FuzeVPN existente. No se pide tu contraseña de Google.
Contraseña de FuzeVPN
Confirmar la vinculación
Recibir un correo de confirmación
Abre el correo de FuzeVPN e introduce el código de confirmación.
Código de confirmación del correo
Confirmar el código
Elegir otra cuenta de Google
Comprobar este intento
El acceso con Google no está disponible. Puedes usar correo y contraseña.
Este intento ha caducado. Cancélalo y vuelve a empezar.
Esta cuenta de Google ya está vinculada a otra cuenta. Tu cuenta y suscripción actuales se conservan.
El acceso con Google ha fallado. Inténtalo de nuevo; tu acceso actual se conserva.
No se pudo confirmar el resultado. Comprueba este intento o cancélalo antes de empezar de nuevo.
No se pudo confirmar la cancelación. Intenta cancelar de nuevo antes de salir.
Acceso con Google cancelado.
Elige tu cuenta de Google…
Verificando tu cuenta…
No se pudo enviar el correo de confirmación. Inténtalo más tarde.
Correo de confirmación enviado. Revisa tu bandeja de entrada.
Espera antes de intentarlo de nuevo.
La contraseña de FuzeVPN es incorrecta. Tu cuenta actual se conserva.
El código de confirmación no es válido o ha caducado.
La sesión ha cambiado. Cancela este intento antes de empezar de nuevo.
No se pudo validar la respuesta. Tu acceso actual se conserva.
Revisa el país y los dos consentimientos.
Elige tu país y acepta los dos documentos para continuar.
Se requiere una comprobación de seguridad adicional. Tu acceso actual se conserva.
La comprobación de seguridad no está disponible. Inténtalo más tarde.''',
'pt': '''Continuar com o Google
ou
Sua conta FuzeVPN
Conclua sua conta
País de residência
Escolha seu país e leia os dois documentos para criar sua conta FuzeVPN.
Vincule sua conta de convidado ao Google. Sua assinatura e seu dispositivo continuam associados a esta conta.
Vincular Google ao FuzeVPN
Confirme o acesso à sua conta FuzeVPN existente. Sua senha do Google não é solicitada.
Senha do FuzeVPN
Confirmar vinculação
Receber e-mail de confirmação
Abra o e-mail do FuzeVPN e insira o código de confirmação.
Código de confirmação por e-mail
Confirmar código
Escolher outra conta Google
Verificar esta tentativa
O login com Google está indisponível. Você pode usar e-mail e senha.
Esta tentativa expirou. Cancele e comece novamente.
Esta conta Google já está vinculada a outra conta. Sua conta e assinatura atuais são mantidas.
O login com Google falhou. Tente novamente; seu acesso atual é mantido.
Não foi possível confirmar o resultado. Verifique esta tentativa ou cancele antes de recomeçar.
Não foi possível confirmar o cancelamento. Tente cancelar novamente antes de sair.
Login com Google cancelado.
Escolha sua conta Google…
Verificando sua conta…
Não foi possível enviar o e-mail de confirmação. Tente mais tarde.
E-mail de confirmação enviado. Confira sua caixa de entrada.
Aguarde antes de tentar novamente.
A senha do FuzeVPN está incorreta. Sua conta atual é mantida.
O código de confirmação é inválido ou expirou.
A sessão mudou. Cancele esta tentativa antes de recomeçar.
Não foi possível validar a resposta. Seu acesso atual é mantido.
Verifique o país e os dois consentimentos.
Escolha seu país e aceite os dois documentos para continuar.
Uma verificação adicional de segurança é necessária. Seu acesso atual é mantido.
A verificação de segurança está indisponível. Tente mais tarde.''',
'de': '''Mit Google fortfahren
oder
Ihr FuzeVPN-Konto
Konto fertigstellen
Wohnsitzland
Wählen Sie Ihr Land und lesen Sie beide Dokumente, um Ihr FuzeVPN-Konto zu erstellen.
Verknüpfen Sie Ihr Gastkonto mit Google. Abonnement und Gerät bleiben diesem Konto zugeordnet.
Google mit FuzeVPN verknüpfen
Bestätigen Sie den Zugriff auf Ihr bestehendes FuzeVPN-Konto. Ihr Google-Passwort wird nicht abgefragt.
FuzeVPN-Passwort
Verknüpfung bestätigen
Bestätigungs-E-Mail erhalten
Öffnen Sie die E-Mail von FuzeVPN und geben Sie den Bestätigungscode ein.
Bestätigungscode aus der E-Mail
Code bestätigen
Anderes Google-Konto wählen
Diesen Versuch prüfen
Die Google-Anmeldung ist nicht verfügbar. Sie können E-Mail und Passwort verwenden.
Dieser Versuch ist abgelaufen. Brechen Sie ihn ab und beginnen Sie erneut.
Dieses Google-Konto ist bereits anderweitig verknüpft. Ihr aktuelles Konto und Abonnement bleiben erhalten.
Die Google-Anmeldung ist fehlgeschlagen. Versuchen Sie es erneut; Ihr aktueller Zugriff bleibt erhalten.
Das Ergebnis konnte nicht bestätigt werden. Prüfen Sie diesen Versuch oder brechen Sie ihn vor einem Neustart ab.
Der Abbruch konnte nicht bestätigt werden. Versuchen Sie erneut abzubrechen, bevor Sie diese Seite verlassen.
Google-Anmeldung abgebrochen.
Wählen Sie Ihr Google-Konto…
Konto wird geprüft…
Die Bestätigungs-E-Mail konnte nicht gesendet werden. Versuchen Sie es später erneut.
Bestätigungs-E-Mail gesendet. Prüfen Sie Ihren Posteingang.
Bitte warten Sie vor einem neuen Versuch.
Das FuzeVPN-Passwort ist falsch. Ihr aktuelles Konto bleibt erhalten.
Der Bestätigungscode ist ungültig oder abgelaufen.
Die Sitzung hat sich geändert. Brechen Sie diesen Versuch vor einem Neustart ab.
Die Antwort konnte nicht geprüft werden. Ihr aktueller Zugriff bleibt erhalten.
Prüfen Sie das Land und beide Zustimmungen.
Wählen Sie Ihr Land und stimmen Sie beiden Dokumenten zu, um fortzufahren.
Eine zusätzliche Sicherheitsprüfung ist erforderlich. Ihr aktueller Zugriff bleibt erhalten.
Die Sicherheitsprüfung ist nicht verfügbar. Versuchen Sie es später erneut.''',
'ar': '''المتابعة باستخدام Google
أو
حسابك في FuzeVPN
أكمل إنشاء حسابك
بلد الإقامة
اختر بلدك وراجع المستندين لإنشاء حساب FuzeVPN.
اربط حساب الضيف بحساب Google. يبقى اشتراكك وجهازك مرتبطين بهذا الحساب.
ربط Google بحساب FuzeVPN
أكد الوصول إلى حساب FuzeVPN الحالي. لا تُطلب كلمة مرور Google.
كلمة مرور FuzeVPN
تأكيد الربط
إرسال رسالة تأكيد بالبريد
افتح رسالة FuzeVPN وأدخل رمز التأكيد.
رمز التأكيد عبر البريد
تأكيد الرمز
اختيار حساب Google آخر
التحقق من هذه المحاولة
تسجيل الدخول باستخدام Google غير متاح. يمكنك استخدام البريد وكلمة المرور.
انتهت صلاحية هذه المحاولة. ألغها ثم ابدأ من جديد.
حساب Google هذا مرتبط بحساب آخر. يبقى حسابك واشتراكك الحاليان محفوظين.
تعذر تسجيل الدخول باستخدام Google. أعد المحاولة؛ وصولك الحالي محفوظ.
تعذر تأكيد النتيجة. تحقق من هذه المحاولة أو ألغها قبل البدء من جديد.
تعذر تأكيد الإلغاء. حاول الإلغاء مجددًا قبل مغادرة هذه الشاشة.
تم إلغاء تسجيل الدخول باستخدام Google.
اختر حسابك في Google…
جارٍ التحقق من حسابك…
تعذر إرسال رسالة التأكيد. حاول لاحقًا.
أُرسلت رسالة التأكيد. تحقق من بريدك الوارد.
يرجى الانتظار قبل المحاولة مجددًا.
كلمة مرور FuzeVPN غير صحيحة. حسابك الحالي محفوظ.
رمز التأكيد غير صالح أو انتهت صلاحيته.
تغيرت الجلسة. ألغ هذه المحاولة قبل البدء من جديد.
تعذر التحقق من الرد. وصولك الحالي محفوظ.
تحقق من البلد والموافقتين.
اختر بلدك ووافق على المستندين للمتابعة.
يلزم تحقق أمني إضافي. وصولك الحالي محفوظ.
التحقق الأمني غير متاح. حاول لاحقًا.''',
'tr': '''Google ile devam et
veya
FuzeVPN hesabınız
Hesabınızı tamamlayın
İkamet edilen ülke
FuzeVPN hesabınızı oluşturmak için ülkenizi seçin ve iki belgeyi inceleyin.
Misafir hesabınızı Google ile bağlayın. Aboneliğiniz ve cihazınız bu hesaba bağlı kalır.
Google hesabını FuzeVPN ile bağla
Mevcut FuzeVPN hesabınıza erişimi doğrulayın. Google şifreniz istenmez.
FuzeVPN şifresi
Bağlantıyı onayla
Onay e-postası gönder
FuzeVPN e-postasını açın ve onay kodunu girin.
E-posta onay kodu
Kodu onayla
Başka bir Google hesabı seç
Bu denemeyi kontrol et
Google ile giriş kullanılamıyor. E-posta ve şifrenizi kullanabilirsiniz.
Bu denemenin süresi doldu. İptal edip yeniden başlayın.
Bu Google hesabı başka bir hesaba bağlı. Mevcut hesabınız ve aboneliğiniz korunur.
Google ile giriş başarısız. Tekrar deneyin; mevcut erişiminiz korunur.
Sonuç doğrulanamadı. Bu denemeyi kontrol edin veya yeniden başlamadan önce iptal edin.
İptal doğrulanamadı. Bu ekrandan çıkmadan önce yeniden iptal etmeyi deneyin.
Google ile giriş iptal edildi.
Google hesabınızı seçin…
Hesabınız kontrol ediliyor…
Onay e-postası gönderilemedi. Daha sonra deneyin.
Onay e-postası gönderildi. Gelen kutunuzu kontrol edin.
Tekrar denemeden önce lütfen bekleyin.
FuzeVPN şifresi yanlış. Mevcut hesabınız korunur.
Onay kodu geçersiz veya süresi dolmuş.
Oturum değişti. Yeniden başlamadan önce bu denemeyi iptal edin.
Yanıt doğrulanamadı. Mevcut erişiminiz korunur.
Ülkeyi ve iki onayı kontrol edin.
Devam etmek için ülkenizi seçip iki belgeyi kabul edin.
Ek güvenlik doğrulaması gerekiyor. Mevcut erişiminiz korunur.
Güvenlik doğrulaması kullanılamıyor. Daha sonra deneyin.''',
'ja': '''Google で続行
または
FuzeVPN アカウント
アカウントの設定を完了
居住国
国を選び、2つの文書を確認して FuzeVPN アカウントを作成してください。
ゲストアカウントを Google に関連付けます。サブスクリプションと端末はこのアカウントに残ります。
Google を FuzeVPN に関連付ける
既存の FuzeVPN アカウントへのアクセスを確認します。Google のパスワードは求めません。
FuzeVPN のパスワード
関連付けを確認
確認メールを送信
FuzeVPN からのメールを開き、確認コードを入力してください。
メール確認コード
コードを確認
別の Google アカウントを選ぶ
この操作を確認
Google ログインを利用できません。メールとパスワードを使用できます。
この操作の有効期限が切れました。キャンセルしてやり直してください。
この Google アカウントは別のアカウントに関連付けられています。現在のアカウントとサブスクリプションは保持されます。
Google ログインに失敗しました。再試行してください。現在のアクセスは保持されます。
結果を確認できませんでした。この操作を確認するか、キャンセルしてからやり直してください。
キャンセルを確認できませんでした。この画面を離れる前にキャンセルを再試行してください。
Google ログインをキャンセルしました。
Google アカウントを選んでください…
アカウントを確認中…
確認メールを送信できませんでした。後でもう一度お試しください。
確認メールを送信しました。受信トレイを確認してください。
しばらく待ってから再試行してください。
FuzeVPN のパスワードが正しくありません。現在のアカウントは保持されます。
確認コードが無効、または期限切れです。
セッションが変わりました。この操作をキャンセルしてからやり直してください。
応答を検証できませんでした。現在のアクセスは保持されます。
国と2つの同意を確認してください。
続行するには国を選び、2つの文書に同意してください。
追加のセキュリティ確認が必要です。現在のアクセスは保持されます。
セキュリティ確認を利用できません。後でもう一度お試しください。''',
'id': '''Lanjutkan dengan Google
atau
Akun FuzeVPN Anda
Selesaikan akun Anda
Negara tempat tinggal
Pilih negara Anda dan tinjau kedua dokumen untuk membuat akun FuzeVPN.
Tautkan akun tamu Anda ke Google. Langganan dan perangkat tetap terkait dengan akun ini.
Tautkan Google ke FuzeVPN
Konfirmasikan akses ke akun FuzeVPN Anda yang ada. Kata sandi Google tidak diminta.
Kata sandi FuzeVPN
Konfirmasi penautan
Kirim email konfirmasi
Buka email FuzeVPN dan masukkan kode konfirmasi.
Kode konfirmasi email
Konfirmasi kode
Pilih akun Google lain
Periksa percobaan ini
Login Google tidak tersedia. Anda dapat menggunakan email dan kata sandi.
Percobaan ini kedaluwarsa. Batalkan lalu mulai lagi.
Akun Google ini sudah tertaut ke akun lain. Akun dan langganan Anda saat ini tetap disimpan.
Login Google gagal. Coba lagi; akses Anda saat ini tetap disimpan.
Hasil belum dapat dikonfirmasi. Periksa percobaan ini atau batalkan sebelum memulai lagi.
Pembatalan belum dapat dikonfirmasi. Coba batalkan lagi sebelum meninggalkan layar ini.
Login Google dibatalkan.
Pilih akun Google Anda…
Memeriksa akun Anda…
Email konfirmasi tidak dapat dikirim. Coba lagi nanti.
Email konfirmasi terkirim. Periksa kotak masuk Anda.
Harap tunggu sebelum mencoba lagi.
Kata sandi FuzeVPN salah. Akun Anda saat ini tetap disimpan.
Kode konfirmasi tidak valid atau kedaluwarsa.
Sesi berubah. Batalkan percobaan ini sebelum memulai lagi.
Respons tidak dapat divalidasi. Akses Anda saat ini tetap disimpan.
Periksa negara dan kedua persetujuan.
Pilih negara Anda dan setujui kedua dokumen untuk melanjutkan.
Pemeriksaan keamanan tambahan diperlukan. Akses Anda saat ini tetap disimpan.
Pemeriksaan keamanan tidak tersedia. Coba lagi nanti.''',
'ru': '''Продолжить с Google
или
Ваш аккаунт FuzeVPN
Завершите создание аккаунта
Страна проживания
Выберите страну и ознакомьтесь с двумя документами для создания аккаунта FuzeVPN.
Свяжите гостевой аккаунт с Google. Подписка и устройство останутся привязаны к этому аккаунту.
Связать Google с FuzeVPN
Подтвердите доступ к существующему аккаунту FuzeVPN. Пароль Google не требуется.
Пароль FuzeVPN
Подтвердить привязку
Получить письмо подтверждения
Откройте письмо от FuzeVPN и введите код подтверждения.
Код из письма
Подтвердить код
Выбрать другой аккаунт Google
Проверить эту попытку
Вход через Google недоступен. Можно использовать почту и пароль.
Срок этой попытки истёк. Отмените её и начните снова.
Этот аккаунт Google уже связан с другим аккаунтом. Текущий аккаунт и подписка сохраняются.
Вход через Google не удался. Повторите попытку; текущий доступ сохраняется.
Результат не подтверждён. Проверьте эту попытку или отмените её перед повтором.
Отмена не подтверждена. Попробуйте отменить ещё раз перед выходом из этого экрана.
Вход через Google отменён.
Выберите аккаунт Google…
Проверяем ваш аккаунт…
Не удалось отправить письмо подтверждения. Попробуйте позже.
Письмо подтверждения отправлено. Проверьте входящие.
Подождите перед повторной попыткой.
Неверный пароль FuzeVPN. Текущий аккаунт сохраняется.
Код подтверждения недействителен или просрочен.
Сессия изменилась. Отмените эту попытку перед повтором.
Не удалось проверить ответ. Текущий доступ сохраняется.
Проверьте страну и оба согласия.
Выберите страну и примите оба документа, чтобы продолжить.
Требуется дополнительная проверка безопасности. Текущий доступ сохраняется.
Проверка безопасности недоступна. Попробуйте позже.''',
'it': '''Continua con Google
oppure
Il tuo account FuzeVPN
Completa il tuo account
Paese di residenza
Scegli il tuo paese e leggi i due documenti per creare il tuo account FuzeVPN.
Collega il tuo account ospite a Google. Abbonamento e dispositivo restano associati a questo account.
Collega Google a FuzeVPN
Conferma l’accesso al tuo account FuzeVPN esistente. Non viene richiesta la password di Google.
Password FuzeVPN
Conferma il collegamento
Ricevi un’email di conferma
Apri l’email di FuzeVPN e inserisci il codice di conferma.
Codice di conferma email
Conferma il codice
Scegli un altro account Google
Verifica questo tentativo
L’accesso Google non è disponibile. Puoi usare email e password.
Questo tentativo è scaduto. Annullalo e ricomincia.
Questo account Google è già collegato altrove. Account e abbonamento attuali vengono mantenuti.
L’accesso Google non è riuscito. Riprova; l’accesso attuale viene mantenuto.
Il risultato non è stato confermato. Verifica questo tentativo o annullalo prima di ricominciare.
L’annullamento non è stato confermato. Riprova ad annullare prima di lasciare questa schermata.
Accesso Google annullato.
Scegli il tuo account Google…
Verifica dell’account…
Impossibile inviare l’email di conferma. Riprova più tardi.
Email di conferma inviata. Controlla la posta in arrivo.
Attendi prima di riprovare.
La password FuzeVPN non è corretta. L’account attuale viene mantenuto.
Il codice di conferma non è valido o è scaduto.
La sessione è cambiata. Annulla questo tentativo prima di ricominciare.
Impossibile verificare la risposta. L’accesso attuale viene mantenuto.
Controlla il paese ed entrambi i consensi.
Scegli il tuo paese e accetta i due documenti per continuare.
È necessaria una verifica di sicurezza aggiuntiva. L’accesso attuale viene mantenuto.
La verifica di sicurezza non è disponibile. Riprova più tardi.''',
'ko': '''Google로 계속하기
또는
FuzeVPN 계정
계정 생성 완료
거주 국가
국가를 선택하고 두 문서를 검토하여 FuzeVPN 계정을 만드세요.
게스트 계정을 Google에 연결하세요. 구독과 기기는 이 계정에 그대로 연결됩니다.
Google을 FuzeVPN에 연결
기존 FuzeVPN 계정의 접근 권한을 확인하세요. Google 비밀번호는 요청하지 않습니다.
FuzeVPN 비밀번호
연결 확인
확인 이메일 받기
FuzeVPN 이메일을 열고 확인 코드를 입력하세요.
이메일 확인 코드
코드 확인
다른 Google 계정 선택
이번 시도 확인
Google 로그인을 사용할 수 없습니다. 이메일과 비밀번호를 사용할 수 있습니다.
이번 시도가 만료되었습니다. 취소한 후 다시 시작하세요.
이 Google 계정은 다른 계정에 연결되어 있습니다. 현재 계정과 구독은 유지됩니다.
Google 로그인에 실패했습니다. 다시 시도하세요. 현재 접근 권한은 유지됩니다.
결과를 확인할 수 없습니다. 이번 시도를 확인하거나 취소한 후 다시 시작하세요.
취소를 확인할 수 없습니다. 이 화면을 나가기 전에 취소를 다시 시도하세요.
Google 로그인이 취소되었습니다.
Google 계정을 선택하세요…
계정 확인 중…
확인 이메일을 보내지 못했습니다. 나중에 다시 시도하세요.
확인 이메일을 보냈습니다. 받은편지함을 확인하세요.
잠시 기다린 후 다시 시도하세요.
FuzeVPN 비밀번호가 올바르지 않습니다. 현재 계정은 유지됩니다.
확인 코드가 올바르지 않거나 만료되었습니다.
세션이 변경되었습니다. 이번 시도를 취소한 후 다시 시작하세요.
응답을 검증할 수 없습니다. 현재 접근 권한은 유지됩니다.
국가와 두 동의 항목을 확인하세요.
계속하려면 국가를 선택하고 두 문서에 동의하세요.
추가 보안 확인이 필요합니다. 현재 접근 권한은 유지됩니다.
보안 확인을 사용할 수 없습니다. 나중에 다시 시도하세요.''',
'pl': '''Kontynuuj z Google
lub
Twoje konto FuzeVPN
Dokończ tworzenie konta
Kraj zamieszkania
Wybierz kraj i zapoznaj się z oboma dokumentami, aby utworzyć konto FuzeVPN.
Połącz konto gościa z Google. Subskrypcja i urządzenie pozostaną przypisane do tego konta.
Połącz Google z FuzeVPN
Potwierdź dostęp do istniejącego konta FuzeVPN. Hasło Google nie jest wymagane.
Hasło FuzeVPN
Potwierdź połączenie
Wyślij e-mail potwierdzający
Otwórz e-mail od FuzeVPN i wpisz kod potwierdzenia.
Kod potwierdzenia z e-maila
Potwierdź kod
Wybierz inne konto Google
Sprawdź tę próbę
Logowanie Google jest niedostępne. Możesz użyć e-maila i hasła.
Ta próba wygasła. Anuluj ją i rozpocznij ponownie.
To konto Google jest już połączone z innym kontem. Twoje obecne konto i subskrypcja pozostają zachowane.
Logowanie Google nie powiodło się. Spróbuj ponownie; obecny dostęp pozostaje zachowany.
Nie można potwierdzić wyniku. Sprawdź tę próbę lub anuluj ją przed ponownym rozpoczęciem.
Nie można potwierdzić anulowania. Spróbuj anulować ponownie przed opuszczeniem tego ekranu.
Logowanie Google anulowane.
Wybierz konto Google…
Sprawdzanie konta…
Nie można wysłać e-maila potwierdzającego. Spróbuj później.
E-mail potwierdzający wysłany. Sprawdź skrzynkę odbiorczą.
Zaczekaj przed ponowną próbą.
Hasło FuzeVPN jest nieprawidłowe. Obecne konto pozostaje zachowane.
Kod potwierdzenia jest nieprawidłowy lub wygasł.
Sesja się zmieniła. Anuluj tę próbę przed ponownym rozpoczęciem.
Nie można zweryfikować odpowiedzi. Obecny dostęp pozostaje zachowany.
Sprawdź kraj i obie zgody.
Wybierz kraj i zaakceptuj oba dokumenty, aby kontynuować.
Wymagana jest dodatkowa kontrola bezpieczeństwa. Obecny dostęp pozostaje zachowany.
Kontrola bezpieczeństwa jest niedostępna. Spróbuj później.''',
'nl': '''Doorgaan met Google
of
Uw FuzeVPN-account
Maak uw account compleet
Woonland
Kies uw land en lees beide documenten om uw FuzeVPN-account te maken.
Koppel uw gastaccount aan Google. Uw abonnement en apparaat blijven aan dit account gekoppeld.
Google aan FuzeVPN koppelen
Bevestig toegang tot uw bestaande FuzeVPN-account. Uw Google-wachtwoord wordt niet gevraagd.
FuzeVPN-wachtwoord
Koppeling bevestigen
Een bevestigingsmail ontvangen
Open de e-mail van FuzeVPN en voer de bevestigingscode in.
Bevestigingscode uit e-mail
Code bevestigen
Ander Google-account kiezen
Deze poging controleren
Aanmelden met Google is niet beschikbaar. U kunt e-mail en wachtwoord gebruiken.
Deze poging is verlopen. Annuleer en begin opnieuw.
Dit Google-account is al elders gekoppeld. Uw huidige account en abonnement blijven behouden.
Aanmelden met Google is mislukt. Probeer opnieuw; uw huidige toegang blijft behouden.
Het resultaat kon niet worden bevestigd. Controleer deze poging of annuleer voordat u opnieuw begint.
De annulering kon niet worden bevestigd. Probeer opnieuw te annuleren voordat u dit scherm verlaat.
Aanmelden met Google geannuleerd.
Kies uw Google-account…
Uw account wordt gecontroleerd…
De bevestigingsmail kon niet worden verzonden. Probeer later opnieuw.
Bevestigingsmail verzonden. Controleer uw inbox.
Wacht even voordat u opnieuw probeert.
Het FuzeVPN-wachtwoord is onjuist. Uw huidige account blijft behouden.
De bevestigingscode is ongeldig of verlopen.
De sessie is gewijzigd. Annuleer deze poging voordat u opnieuw begint.
Het antwoord kon niet worden gevalideerd. Uw huidige toegang blijft behouden.
Controleer uw land en beide toestemmingen.
Kies uw land en accepteer beide documenten om door te gaan.
Een extra beveiligingscontrole is vereist. Uw huidige toegang blijft behouden.
De beveiligingscontrole is niet beschikbaar. Probeer later opnieuw.''',
'hi': '''Google के साथ जारी रखें
या
आपका FuzeVPN खाता
अपना खाता पूरा करें
निवास का देश
FuzeVPN खाता बनाने के लिए अपना देश चुनें और दोनों दस्तावेज़ पढ़ें।
अपने अतिथि खाते को Google से जोड़ें। सदस्यता और डिवाइस इसी खाते से जुड़े रहेंगे।
Google को FuzeVPN से जोड़ें
अपने मौजूदा FuzeVPN खाते तक पहुँच की पुष्टि करें। आपका Google पासवर्ड नहीं माँगा जाएगा।
FuzeVPN पासवर्ड
जोड़ने की पुष्टि करें
पुष्टि ईमेल भेजें
FuzeVPN का ईमेल खोलें और पुष्टि कोड दर्ज करें।
ईमेल पुष्टि कोड
कोड की पुष्टि करें
दूसरा Google खाता चुनें
इस प्रयास की जाँच करें
Google साइन-इन उपलब्ध नहीं है। आप ईमेल और पासवर्ड का उपयोग कर सकते हैं।
इस प्रयास की समय-सीमा समाप्त हो गई है। इसे रद्द करके फिर शुरू करें।
यह Google खाता पहले से दूसरे खाते से जुड़ा है। आपका मौजूदा खाता और सदस्यता सुरक्षित हैं।
Google साइन-इन विफल रहा। फिर प्रयास करें; आपकी मौजूदा पहुँच सुरक्षित है।
परिणाम की पुष्टि नहीं हो सकी। इस प्रयास की जाँच करें या फिर शुरू करने से पहले इसे रद्द करें।
रद्द करने की पुष्टि नहीं हो सकी। इस स्क्रीन से बाहर जाने से पहले फिर रद्द करने का प्रयास करें।
Google साइन-इन रद्द किया गया।
अपना Google खाता चुनें…
आपके खाते की जाँच हो रही है…
पुष्टि ईमेल नहीं भेजा जा सका। बाद में प्रयास करें।
पुष्टि ईमेल भेजा गया। अपना इनबॉक्स देखें।
फिर प्रयास करने से पहले प्रतीक्षा करें।
FuzeVPN पासवर्ड गलत है। आपका मौजूदा खाता सुरक्षित है।
पुष्टि कोड अमान्य है या उसकी समय-सीमा समाप्त हो गई है।
सत्र बदल गया है। फिर शुरू करने से पहले इस प्रयास को रद्द करें।
उत्तर की पुष्टि नहीं हो सकी। आपकी मौजूदा पहुँच सुरक्षित है।
देश और दोनों सहमतियों की जाँच करें।
जारी रखने के लिए अपना देश चुनें और दोनों दस्तावेज़ स्वीकार करें।
अतिरिक्त सुरक्षा जाँच आवश्यक है। आपकी मौजूदा पहुँच सुरक्षित है।
सुरक्षा जाँच उपलब्ध नहीं है। बाद में प्रयास करें।''',
'vi': '''Tiếp tục với Google
hoặc
Tài khoản FuzeVPN của bạn
Hoàn tất tài khoản
Quốc gia cư trú
Chọn quốc gia và đọc cả hai tài liệu để tạo tài khoản FuzeVPN.
Liên kết tài khoản khách với Google. Gói đăng ký và thiết bị vẫn thuộc tài khoản này.
Liên kết Google với FuzeVPN
Xác nhận quyền truy cập tài khoản FuzeVPN hiện có. Không yêu cầu mật khẩu Google.
Mật khẩu FuzeVPN
Xác nhận liên kết
Nhận email xác nhận
Mở email FuzeVPN và nhập mã xác nhận.
Mã xác nhận qua email
Xác nhận mã
Chọn tài khoản Google khác
Kiểm tra lần thử này
Đăng nhập Google không khả dụng. Bạn có thể dùng email và mật khẩu.
Lần thử này đã hết hạn. Hủy rồi bắt đầu lại.
Tài khoản Google này đã liên kết với tài khoản khác. Tài khoản và gói đăng ký hiện tại được giữ nguyên.
Đăng nhập Google thất bại. Thử lại; quyền truy cập hiện tại được giữ nguyên.
Chưa thể xác nhận kết quả. Kiểm tra lần thử này hoặc hủy trước khi bắt đầu lại.
Chưa thể xác nhận việc hủy. Thử hủy lại trước khi rời màn hình này.
Đã hủy đăng nhập Google.
Chọn tài khoản Google…
Đang kiểm tra tài khoản…
Không thể gửi email xác nhận. Thử lại sau.
Đã gửi email xác nhận. Kiểm tra hộp thư đến.
Vui lòng đợi trước khi thử lại.
Mật khẩu FuzeVPN không đúng. Tài khoản hiện tại được giữ nguyên.
Mã xác nhận không hợp lệ hoặc đã hết hạn.
Phiên đã thay đổi. Hủy lần thử này trước khi bắt đầu lại.
Không thể xác thực phản hồi. Quyền truy cập hiện tại được giữ nguyên.
Kiểm tra quốc gia và cả hai sự đồng ý.
Chọn quốc gia và chấp nhận cả hai tài liệu để tiếp tục.
Cần kiểm tra bảo mật bổ sung. Quyền truy cập hiện tại được giữ nguyên.
Kiểm tra bảo mật không khả dụng. Thử lại sau.''',
'uk': '''Продовжити з Google
або
Ваш обліковий запис FuzeVPN
Завершіть створення облікового запису
Країна проживання
Виберіть країну та ознайомтеся з двома документами, щоб створити обліковий запис FuzeVPN.
Пов’яжіть гостьовий обліковий запис із Google. Підписка та пристрій залишаться пов’язаними з цим записом.
Пов’язати Google з FuzeVPN
Підтвердьте доступ до наявного облікового запису FuzeVPN. Пароль Google не потрібен.
Пароль FuzeVPN
Підтвердити зв’язування
Отримати лист підтвердження
Відкрийте лист від FuzeVPN і введіть код підтвердження.
Код підтвердження з листа
Підтвердити код
Вибрати інший обліковий запис Google
Перевірити цю спробу
Вхід через Google недоступний. Можна використати пошту й пароль.
Термін цієї спроби минув. Скасуйте її та почніть знову.
Цей обліковий запис Google уже пов’язаний з іншим записом. Поточний обліковий запис і підписку збережено.
Вхід через Google не вдався. Спробуйте знову; поточний доступ збережено.
Результат не підтверджено. Перевірте цю спробу або скасуйте її перед повтором.
Скасування не підтверджено. Спробуйте скасувати ще раз перед виходом із цього екрана.
Вхід через Google скасовано.
Виберіть обліковий запис Google…
Перевіряємо обліковий запис…
Не вдалося надіслати лист підтвердження. Спробуйте пізніше.
Лист підтвердження надіслано. Перевірте вхідні.
Зачекайте перед повторною спробою.
Неправильний пароль FuzeVPN. Поточний обліковий запис збережено.
Код підтвердження недійсний або прострочений.
Сеанс змінився. Скасуйте цю спробу перед повтором.
Не вдалося перевірити відповідь. Поточний доступ збережено.
Перевірте країну та обидві згоди.
Виберіть країну та прийміть обидва документи, щоб продовжити.
Потрібна додаткова перевірка безпеки. Поточний доступ збережено.
Перевірка безпеки недоступна. Спробуйте пізніше.''',
'th': '''ดำเนินการต่อด้วย Google
หรือ
บัญชี FuzeVPN ของคุณ
สร้างบัญชีให้เสร็จสมบูรณ์
ประเทศที่พำนัก
เลือกประเทศและอ่านเอกสารทั้งสองฉบับเพื่อสร้างบัญชี FuzeVPN
เชื่อมบัญชีผู้เยี่ยมชมกับ Google การสมัครสมาชิกและอุปกรณ์จะยังคงผูกกับบัญชีนี้
เชื่อม Google กับ FuzeVPN
ยืนยันการเข้าถึงบัญชี FuzeVPN ที่มีอยู่ ขั้นตอนนี้ไม่ขอรหัสผ่าน Google
รหัสผ่าน FuzeVPN
ยืนยันการเชื่อมบัญชี
รับอีเมลยืนยัน
เปิดอีเมลจาก FuzeVPN และป้อนรหัสยืนยัน
รหัสยืนยันทางอีเมล
ยืนยันรหัส
เลือกบัญชี Google อื่น
ตรวจสอบความพยายามนี้
ไม่สามารถลงชื่อเข้าใช้ Google ได้ คุณสามารถใช้อีเมลและรหัสผ่าน
ความพยายามนี้หมดอายุแล้ว ยกเลิกแล้วเริ่มใหม่
บัญชี Google นี้เชื่อมกับบัญชีอื่นแล้ว บัญชีและการสมัครสมาชิกปัจจุบันจะยังคงอยู่
ลงชื่อเข้าใช้ Google ไม่สำเร็จ ลองอีกครั้ง การเข้าถึงปัจจุบันจะยังคงอยู่
ไม่สามารถยืนยันผลได้ ตรวจสอบความพยายามนี้หรือยกเลิกก่อนเริ่มใหม่
ไม่สามารถยืนยันการยกเลิกได้ ลองยกเลิกอีกครั้งก่อนออกจากหน้าจอนี้
ยกเลิกการลงชื่อเข้าใช้ Google แล้ว
เลือกบัญชี Google ของคุณ…
กำลังตรวจสอบบัญชี…
ส่งอีเมลยืนยันไม่ได้ โปรดลองภายหลัง
ส่งอีเมลยืนยันแล้ว ตรวจสอบกล่องจดหมาย
โปรดรอก่อนลองอีกครั้ง
รหัสผ่าน FuzeVPN ไม่ถูกต้อง บัญชีปัจจุบันจะยังคงอยู่
รหัสยืนยันไม่ถูกต้องหรือหมดอายุ
เซสชันเปลี่ยนแล้ว ยกเลิกความพยายามนี้ก่อนเริ่มใหม่
ตรวจสอบคำตอบไม่ได้ การเข้าถึงปัจจุบันจะยังคงอยู่
ตรวจสอบประเทศและความยินยอมทั้งสองรายการ
เลือกประเทศและยอมรับเอกสารทั้งสองฉบับเพื่อดำเนินการต่อ
ต้องตรวจสอบความปลอดภัยเพิ่มเติม การเข้าถึงปัจจุบันจะยังคงอยู่
ไม่สามารถตรวจสอบความปลอดภัยได้ โปรดลองภายหลัง''',
'zh-Hans': '''使用 Google 继续
或
您的 FuzeVPN 账户
完成账户创建
居住国家或地区
选择居住国家或地区并阅读两份文件，以创建 FuzeVPN 账户。
将访客账户关联到 Google。订阅和设备仍归属于此账户。
将 Google 关联到 FuzeVPN
确认您对现有 FuzeVPN 账户的访问权限。此步骤不会要求提供 Google 密码。
FuzeVPN 密码
确认关联
接收确认邮件
打开 FuzeVPN 邮件并输入确认码。
邮件确认码
确认代码
选择其他 Google 账户
检查此次尝试
Google 登录不可用。您可以使用邮箱和密码。
此次尝试已过期。请取消后重新开始。
此 Google 账户已关联到其他账户。当前账户和订阅将被保留。
Google 登录失败。请重试，当前访问权限将被保留。
无法确认结果。请检查此次尝试，或取消后重新开始。
无法确认取消操作。请在离开此页面前再次尝试取消。
已取消 Google 登录。
请选择 Google 账户…
正在检查账户…
无法发送确认邮件。请稍后重试。
已发送确认邮件。请检查收件箱。
请稍等后重试。
FuzeVPN 密码不正确。当前账户将被保留。
确认码无效或已过期。
会话已更改。请取消此次尝试后重新开始。
无法验证响应。当前访问权限将被保留。
请检查国家或地区及两项同意。
选择居住国家或地区并同意两份文件后继续。
需要额外的安全验证。当前访问权限将被保留。
安全验证不可用。请稍后重试。''',
'zh-Hant': '''使用 Google 繼續
或
您的 FuzeVPN 帳戶
完成帳戶建立
居住國家或地區
選擇居住國家或地區並閱讀兩份文件，以建立 FuzeVPN 帳戶。
將訪客帳戶連結至 Google。訂閱和裝置仍歸屬於此帳戶。
將 Google 連結至 FuzeVPN
確認您對現有 FuzeVPN 帳戶的存取權限。此步驟不會要求提供 Google 密碼。
FuzeVPN 密碼
確認連結
接收確認郵件
開啟 FuzeVPN 郵件並輸入確認碼。
郵件確認碼
確認代碼
選擇其他 Google 帳戶
檢查此次嘗試
Google 登入無法使用。您可以使用電子郵件和密碼。
此次嘗試已過期。請取消後重新開始。
此 Google 帳戶已連結至其他帳戶。目前的帳戶和訂閱將被保留。
Google 登入失敗。請重試，目前的存取權限將被保留。
無法確認結果。請檢查此次嘗試，或取消後重新開始。
無法確認取消操作。請在離開此頁面前再次嘗試取消。
已取消 Google 登入。
請選擇 Google 帳戶…
正在檢查帳戶…
無法傳送確認郵件。請稍後重試。
已傳送確認郵件。請檢查收件匣。
請稍候再重試。
FuzeVPN 密碼不正確。目前的帳戶將被保留。
確認碼無效或已過期。
工作階段已變更。請取消此次嘗試後重新開始。
無法驗證回應。目前的存取權限將被保留。
請檢查國家或地區及兩項同意。
選擇居住國家或地區並同意兩份文件後繼續。
需要額外的安全驗證。目前的存取權限將被保留。
安全驗證無法使用。請稍後重試。''',
'fa': '''ادامه با Google
یا
حساب FuzeVPN شما
ساخت حساب را تکمیل کنید
کشور محل اقامت
برای ساخت حساب FuzeVPN، کشور خود را انتخاب کنید و دو سند را بخوانید.
حساب مهمان را به Google پیوند دهید. اشتراک و دستگاه به همین حساب متصل می‌مانند.
پیوند Google به FuzeVPN
دسترسی به حساب موجود FuzeVPN را تأیید کنید. گذرواژه Google درخواست نمی‌شود.
گذرواژه FuzeVPN
تأیید پیوند
دریافت ایمیل تأیید
ایمیل FuzeVPN را باز کنید و کد تأیید را وارد کنید.
کد تأیید ایمیل
تأیید کد
انتخاب حساب Google دیگر
بررسی این تلاش
ورود با Google در دسترس نیست. می‌توانید از ایمیل و گذرواژه استفاده کنید.
این تلاش منقضی شده است. آن را لغو کنید و دوباره شروع کنید.
این حساب Google به حساب دیگری متصل است. حساب و اشتراک فعلی شما حفظ می‌شوند.
ورود با Google ناموفق بود. دوباره تلاش کنید؛ دسترسی فعلی شما حفظ می‌شود.
نتیجه تأیید نشد. این تلاش را بررسی کنید یا پیش از شروع دوباره آن را لغو کنید.
لغو تأیید نشد. پیش از خروج از این صفحه دوباره برای لغو تلاش کنید.
ورود با Google لغو شد.
حساب Google خود را انتخاب کنید…
در حال بررسی حساب…
ایمیل تأیید ارسال نشد. بعداً دوباره تلاش کنید.
ایمیل تأیید ارسال شد. صندوق ورودی خود را بررسی کنید.
پیش از تلاش دوباره کمی صبر کنید.
گذرواژه FuzeVPN نادرست است. حساب فعلی شما حفظ می‌شود.
کد تأیید نامعتبر یا منقضی شده است.
نشست تغییر کرده است. پیش از شروع دوباره این تلاش را لغو کنید.
پاسخ تأیید نشد. دسترسی فعلی شما حفظ می‌شود.
کشور و هر دو رضایت را بررسی کنید.
برای ادامه کشور خود را انتخاب کنید و هر دو سند را بپذیرید.
بررسی امنیتی دیگری لازم است. دسترسی فعلی شما حفظ می‌شود.
بررسی امنیتی در دسترس نیست. بعداً دوباره تلاش کنید.''',
'ur': '''Google کے ساتھ جاری رکھیں
یا
آپ کا FuzeVPN اکاؤنٹ
اپنا اکاؤنٹ مکمل کریں
رہائش کا ملک
FuzeVPN اکاؤنٹ بنانے کے لیے اپنا ملک منتخب کریں اور دونوں دستاویزات پڑھیں۔
مہمان اکاؤنٹ کو Google سے منسلک کریں۔ رکنیت اور آلہ اسی اکاؤنٹ سے منسلک رہیں گے۔
Google کو FuzeVPN سے منسلک کریں
موجودہ FuzeVPN اکاؤنٹ تک رسائی کی تصدیق کریں۔ Google پاس ورڈ نہیں مانگا جائے گا۔
FuzeVPN پاس ورڈ
لنک کی تصدیق کریں
تصدیقی ای میل بھیجیں
FuzeVPN کی ای میل کھولیں اور تصدیقی کوڈ درج کریں۔
ای میل کا تصدیقی کوڈ
کوڈ کی تصدیق کریں
دوسرا Google اکاؤنٹ منتخب کریں
اس کوشش کی جانچ کریں
Google سائن ان دستیاب نہیں۔ آپ ای میل اور پاس ورڈ استعمال کر سکتے ہیں۔
اس کوشش کی مدت ختم ہو گئی ہے۔ اسے منسوخ کر کے دوبارہ شروع کریں۔
یہ Google اکاؤنٹ پہلے ہی دوسرے اکاؤنٹ سے منسلک ہے۔ موجودہ اکاؤنٹ اور رکنیت محفوظ رہیں گے۔
Google سائن ان ناکام ہوا۔ دوبارہ کوشش کریں؛ موجودہ رسائی محفوظ رہے گی۔
نتیجے کی تصدیق نہیں ہو سکی۔ اس کوشش کی جانچ کریں یا دوبارہ شروع کرنے سے پہلے اسے منسوخ کریں۔
منسوخی کی تصدیق نہیں ہو سکی۔ یہ اسکرین چھوڑنے سے پہلے دوبارہ منسوخ کرنے کی کوشش کریں۔
Google سائن ان منسوخ ہو گیا۔
اپنا Google اکاؤنٹ منتخب کریں…
اکاؤنٹ کی جانچ ہو رہی ہے…
تصدیقی ای میل نہیں بھیجی جا سکی۔ بعد میں کوشش کریں۔
تصدیقی ای میل بھیج دی گئی۔ اپنا ان باکس دیکھیں۔
دوبارہ کوشش کرنے سے پہلے انتظار کریں۔
FuzeVPN پاس ورڈ غلط ہے۔ موجودہ اکاؤنٹ محفوظ رہے گا۔
تصدیقی کوڈ غلط ہے یا اس کی مدت ختم ہو گئی ہے۔
سیشن بدل گیا ہے۔ دوبارہ شروع کرنے سے پہلے اس کوشش کو منسوخ کریں۔
جواب کی تصدیق نہیں ہو سکی۔ موجودہ رسائی محفوظ رہے گی۔
ملک اور دونوں رضامندیوں کی جانچ کریں۔
جاری رکھنے کے لیے ملک منتخب کریں اور دونوں دستاویزات قبول کریں۔
اضافی سیکیورٹی جانچ ضروری ہے۔ موجودہ رسائی محفوظ رہے گی۔
سیکیورٹی جانچ دستیاب نہیں۔ بعد میں کوشش کریں۔''',
'fil': '''Magpatuloy gamit ang Google
o
Ang iyong FuzeVPN account
Kumpletuhin ang iyong account
Bansang tinitirhan
Piliin ang iyong bansa at basahin ang dalawang dokumento para gumawa ng FuzeVPN account.
Iugnay ang guest account sa Google. Mananatiling kaugnay ng account na ito ang subscription at device.
Iugnay ang Google sa FuzeVPN
Kumpirmahin ang access sa kasalukuyang FuzeVPN account. Hindi hinihingi ang Google password.
FuzeVPN password
Kumpirmahin ang pag-uugnay
Magpadala ng email sa pagkumpirma
Buksan ang FuzeVPN email at ilagay ang code sa pagkumpirma.
Code sa pagkumpirma sa email
Kumpirmahin ang code
Pumili ng ibang Google account
Suriin ang pagsubok na ito
Hindi available ang Google sign-in. Maaari mong gamitin ang email at password.
Nag-expire ang pagsubok na ito. Kanselahin at magsimula muli.
Nakaugnay na ang Google account na ito sa ibang account. Nananatili ang kasalukuyang account at subscription.
Nabigo ang Google sign-in. Subukang muli; nananatili ang kasalukuyang access.
Hindi makumpirma ang resulta. Suriin ang pagsubok o kanselahin bago magsimula muli.
Hindi makumpirma ang pagkansela. Subukang kanselahin muli bago umalis sa screen na ito.
Nakansela ang Google sign-in.
Piliin ang iyong Google account…
Sinusuri ang iyong account…
Hindi maipadala ang email sa pagkumpirma. Subukan sa ibang pagkakataon.
Naipadala ang email sa pagkumpirma. Tingnan ang iyong inbox.
Maghintay bago subukang muli.
Mali ang FuzeVPN password. Nananatili ang kasalukuyang account.
Hindi wasto o expired na ang code sa pagkumpirma.
Nagbago ang session. Kanselahin ang pagsubok na ito bago magsimula muli.
Hindi ma-validate ang tugon. Nananatili ang kasalukuyang access.
Suriin ang bansa at parehong pahintulot.
Piliin ang bansa at tanggapin ang dalawang dokumento para magpatuloy.
Kailangan ng karagdagang pagsusuri sa seguridad. Nananatili ang kasalukuyang access.
Hindi available ang pagsusuri sa seguridad. Subukan sa ibang pagkakataon.''',
'ms': '''Teruskan dengan Google
atau
Akaun FuzeVPN anda
Lengkapkan akaun anda
Negara kediaman
Pilih negara anda dan baca kedua-dua dokumen untuk mencipta akaun FuzeVPN.
Pautkan akaun tetamu kepada Google. Langganan dan peranti kekal dikaitkan dengan akaun ini.
Pautkan Google kepada FuzeVPN
Sahkan akses ke akaun FuzeVPN sedia ada. Kata laluan Google tidak diminta.
Kata laluan FuzeVPN
Sahkan pautan
Terima e-mel pengesahan
Buka e-mel FuzeVPN dan masukkan kod pengesahan.
Kod pengesahan e-mel
Sahkan kod
Pilih akaun Google lain
Semak percubaan ini
Log masuk Google tidak tersedia. Anda boleh menggunakan e-mel dan kata laluan.
Percubaan ini tamat tempoh. Batalkan kemudian mulakan semula.
Akaun Google ini sudah dipautkan kepada akaun lain. Akaun dan langganan semasa dikekalkan.
Log masuk Google gagal. Cuba lagi; akses semasa dikekalkan.
Hasil tidak dapat disahkan. Semak percubaan ini atau batalkan sebelum bermula semula.
Pembatalan tidak dapat disahkan. Cuba batalkan lagi sebelum meninggalkan skrin ini.
Log masuk Google dibatalkan.
Pilih akaun Google anda…
Menyemak akaun anda…
E-mel pengesahan tidak dapat dihantar. Cuba lagi kemudian.
E-mel pengesahan dihantar. Semak peti masuk anda.
Sila tunggu sebelum mencuba lagi.
Kata laluan FuzeVPN tidak betul. Akaun semasa dikekalkan.
Kod pengesahan tidak sah atau tamat tempoh.
Sesi telah berubah. Batalkan percubaan ini sebelum bermula semula.
Respons tidak dapat disahkan. Akses semasa dikekalkan.
Semak negara dan kedua-dua persetujuan.
Pilih negara dan terima kedua-dua dokumen untuk meneruskan.
Semakan keselamatan tambahan diperlukan. Akses semasa dikekalkan.
Semakan keselamatan tidak tersedia. Cuba lagi kemudian.''',
'ro': '''Continuă cu Google
sau
Contul tău FuzeVPN
Finalizează contul
Țara de reședință
Alege țara și citește ambele documente pentru a crea contul FuzeVPN.
Asociază contul de oaspete cu Google. Abonamentul și dispozitivul rămân asociate acestui cont.
Asociază Google cu FuzeVPN
Confirmă accesul la contul FuzeVPN existent. Nu se solicită parola Google.
Parola FuzeVPN
Confirmă asocierea
Primește un e-mail de confirmare
Deschide e-mailul FuzeVPN și introdu codul de confirmare.
Codul de confirmare din e-mail
Confirmă codul
Alege alt cont Google
Verifică această încercare
Autentificarea Google nu este disponibilă. Poți folosi e-mailul și parola.
Această încercare a expirat. Anuleaz-o și începe din nou.
Acest cont Google este deja asociat altui cont. Contul și abonamentul actuale sunt păstrate.
Autentificarea Google a eșuat. Încearcă din nou; accesul actual este păstrat.
Rezultatul nu a putut fi confirmat. Verifică această încercare sau anuleaz-o înainte de a reîncepe.
Anularea nu a putut fi confirmată. Încearcă să anulezi din nou înainte de a părăsi ecranul.
Autentificare Google anulată.
Alege contul Google…
Se verifică contul…
E-mailul de confirmare nu a putut fi trimis. Încearcă mai târziu.
E-mail de confirmare trimis. Verifică mesajele primite.
Așteaptă înainte de a încerca din nou.
Parola FuzeVPN este incorectă. Contul actual este păstrat.
Codul de confirmare este invalid sau a expirat.
Sesiunea s-a schimbat. Anulează această încercare înainte de a reîncepe.
Răspunsul nu a putut fi validat. Accesul actual este păstrat.
Verifică țara și ambele acorduri.
Alege țara și acceptă ambele documente pentru a continua.
Este necesară o verificare suplimentară de securitate. Accesul actual este păstrat.
Verificarea de securitate nu este disponibilă. Încearcă mai târziu.''',
'cs': '''Pokračovat přes Google
nebo
Váš účet FuzeVPN
Dokončete svůj účet
Země bydliště
Vyberte zemi a přečtěte si oba dokumenty pro vytvoření účtu FuzeVPN.
Propojte účet hosta s Googlem. Předplatné i zařízení zůstanou přiřazené k tomuto účtu.
Propojit Google s FuzeVPN
Potvrďte přístup ke svému existujícímu účtu FuzeVPN. Heslo Google není požadováno.
Heslo FuzeVPN
Potvrdit propojení
Poslat potvrzovací e-mail
Otevřete e-mail od FuzeVPN a zadejte potvrzovací kód.
Potvrzovací kód z e-mailu
Potvrdit kód
Vybrat jiný účet Google
Ověřit tento pokus
Přihlášení Google není dostupné. Můžete použít e-mail a heslo.
Platnost tohoto pokusu vypršela. Zrušte jej a začněte znovu.
Tento účet Google je již propojen s jiným účtem. Současný účet a předplatné zůstávají zachovány.
Přihlášení Google se nezdařilo. Zkuste to znovu; současný přístup zůstává zachován.
Výsledek nelze potvrdit. Ověřte tento pokus nebo jej zrušte před novým začátkem.
Zrušení nelze potvrdit. Před opuštěním obrazovky zkuste znovu zrušit.
Přihlášení Google zrušeno.
Vyberte účet Google…
Ověřování účtu…
Potvrzovací e-mail nelze odeslat. Zkuste to později.
Potvrzovací e-mail odeslán. Zkontrolujte doručenou poštu.
Před dalším pokusem vyčkejte.
Heslo FuzeVPN je nesprávné. Současný účet zůstává zachován.
Potvrzovací kód je neplatný nebo vypršel.
Relace se změnila. Zrušte tento pokus před novým začátkem.
Odpověď nelze ověřit. Současný přístup zůstává zachován.
Zkontrolujte zemi a oba souhlasy.
Vyberte zemi a přijměte oba dokumenty pro pokračování.
Je nutná další bezpečnostní kontrola. Současný přístup zůstává zachován.
Bezpečnostní kontrola není dostupná. Zkuste to později.''',
'sv': '''Fortsätt med Google
eller
Ditt FuzeVPN-konto
Slutför ditt konto
Bosättningsland
Välj ditt land och läs båda dokumenten för att skapa ditt FuzeVPN-konto.
Koppla ditt gästkonto till Google. Abonnemang och enhet förblir kopplade till detta konto.
Koppla Google till FuzeVPN
Bekräfta åtkomst till ditt befintliga FuzeVPN-konto. Ditt Google-lösenord efterfrågas inte.
FuzeVPN-lösenord
Bekräfta kopplingen
Få ett bekräftelsemejl
Öppna mejlet från FuzeVPN och ange bekräftelsekoden.
Bekräftelsekod från mejlet
Bekräfta koden
Välj ett annat Google-konto
Kontrollera detta försök
Google-inloggning är inte tillgänglig. Du kan använda e-post och lösenord.
Detta försök har löpt ut. Avbryt och börja om.
Detta Google-konto är redan kopplat någon annanstans. Ditt nuvarande konto och abonnemang behålls.
Google-inloggningen misslyckades. Försök igen; din nuvarande åtkomst behålls.
Resultatet kunde inte bekräftas. Kontrollera försöket eller avbryt innan du börjar om.
Avbrottet kunde inte bekräftas. Försök avbryta igen innan du lämnar skärmen.
Google-inloggning avbruten.
Välj ditt Google-konto…
Kontrollerar ditt konto…
Bekräftelsemejlet kunde inte skickas. Försök senare.
Bekräftelsemejl skickat. Kontrollera din inkorg.
Vänta innan du försöker igen.
FuzeVPN-lösenordet är fel. Ditt nuvarande konto behålls.
Bekräftelsekoden är ogiltig eller har löpt ut.
Sessionen har ändrats. Avbryt försöket innan du börjar om.
Svaret kunde inte valideras. Din nuvarande åtkomst behålls.
Kontrollera landet och båda samtyckena.
Välj ditt land och godkänn båda dokumenten för att fortsätta.
En ytterligare säkerhetskontroll krävs. Din nuvarande åtkomst behålls.
Säkerhetskontrollen är inte tillgänglig. Försök senare.''',
'da': '''Fortsæt med Google
eller
Din FuzeVPN-konto
Færdiggør din konto
Bopælsland
Vælg dit land og læs begge dokumenter for at oprette din FuzeVPN-konto.
Knyt din gæstekonto til Google. Abonnement og enhed forbliver knyttet til denne konto.
Knyt Google til FuzeVPN
Bekræft adgang til din eksisterende FuzeVPN-konto. Din Google-adgangskode efterspørges ikke.
FuzeVPN-adgangskode
Bekræft tilknytning
Modtag en bekræftelsesmail
Åbn mailen fra FuzeVPN og indtast bekræftelseskoden.
Bekræftelseskode fra mail
Bekræft koden
Vælg en anden Google-konto
Kontrollér dette forsøg
Google-login er ikke tilgængeligt. Du kan bruge e-mail og adgangskode.
Dette forsøg er udløbet. Annuller det og begynd igen.
Denne Google-konto er allerede knyttet til en anden konto. Din nuværende konto og dit abonnement bevares.
Google-login mislykkedes. Prøv igen; din nuværende adgang bevares.
Resultatet kunne ikke bekræftes. Kontrollér forsøget eller annuller før du begynder igen.
Annulleringen kunne ikke bekræftes. Prøv at annullere igen, før du forlader skærmen.
Google-login annulleret.
Vælg din Google-konto…
Kontrollerer din konto…
Bekræftelsesmailen kunne ikke sendes. Prøv senere.
Bekræftelsesmail sendt. Kontrollér din indbakke.
Vent før du prøver igen.
FuzeVPN-adgangskoden er forkert. Din nuværende konto bevares.
Bekræftelseskoden er ugyldig eller udløbet.
Sessionen er ændret. Annuller dette forsøg, før du begynder igen.
Svaret kunne ikke valideres. Din nuværende adgang bevares.
Kontrollér landet og begge samtykker.
Vælg dit land og accepter begge dokumenter for at fortsætte.
En yderligere sikkerhedskontrol er nødvendig. Din nuværende adgang bevares.
Sikkerhedskontrollen er ikke tilgængelig. Prøv senere.''',
'nb': '''Fortsett med Google
eller
FuzeVPN-kontoen din
Fullfør kontoen din
Bostedsland
Velg landet ditt og les begge dokumentene for å opprette FuzeVPN-kontoen.
Knytt gjestekontoen til Google. Abonnement og enhet forblir knyttet til denne kontoen.
Knytt Google til FuzeVPN
Bekreft tilgang til din eksisterende FuzeVPN-konto. Google-passordet ditt blir ikke etterspurt.
FuzeVPN-passord
Bekreft tilknytning
Motta en bekreftelsesmail
Åpne e-posten fra FuzeVPN og skriv inn bekreftelseskoden.
Bekreftelseskode fra e-post
Bekreft koden
Velg en annen Google-konto
Kontroller dette forsøket
Google-pålogging er ikke tilgjengelig. Du kan bruke e-post og passord.
Dette forsøket er utløpt. Avbryt og start på nytt.
Denne Google-kontoen er allerede knyttet til en annen konto. Nåværende konto og abonnement beholdes.
Google-pålogging mislyktes. Prøv igjen; nåværende tilgang beholdes.
Resultatet kunne ikke bekreftes. Kontroller forsøket eller avbryt før du starter på nytt.
Avbruddet kunne ikke bekreftes. Prøv å avbryte igjen før du forlater skjermen.
Google-pålogging avbrutt.
Velg Google-kontoen din…
Kontrollerer kontoen din…
Bekreftelsesmailen kunne ikke sendes. Prøv senere.
Bekreftelsesmail sendt. Kontroller innboksen din.
Vent før du prøver igjen.
FuzeVPN-passordet er feil. Nåværende konto beholdes.
Bekreftelseskoden er ugyldig eller utløpt.
Økten er endret. Avbryt dette forsøket før du starter på nytt.
Svaret kunne ikke valideres. Nåværende tilgang beholdes.
Kontroller landet og begge samtykkene.
Velg landet ditt og godta begge dokumentene for å fortsette.
En ekstra sikkerhetskontroll kreves. Nåværende tilgang beholdes.
Sikkerhetskontrollen er ikke tilgjengelig. Prøv senere.''',
'el': '''Συνέχεια με Google
ή
Ο λογαριασμός σας FuzeVPN
Ολοκληρώστε τον λογαριασμό σας
Χώρα κατοικίας
Επιλέξτε τη χώρα σας και διαβάστε τα δύο έγγραφα για να δημιουργήσετε λογαριασμό FuzeVPN.
Συνδέστε τον λογαριασμό επισκέπτη με το Google. Η συνδρομή και η συσκευή παραμένουν σε αυτόν τον λογαριασμό.
Σύνδεση Google με FuzeVPN
Επιβεβαιώστε την πρόσβαση στον υπάρχοντα λογαριασμό FuzeVPN. Δεν ζητείται ο κωδικός Google.
Κωδικός FuzeVPN
Επιβεβαίωση σύνδεσης
Λήψη email επιβεβαίωσης
Ανοίξτε το email του FuzeVPN και εισαγάγετε τον κωδικό επιβεβαίωσης.
Κωδικός επιβεβαίωσης email
Επιβεβαίωση κωδικού
Επιλογή άλλου λογαριασμού Google
Έλεγχος αυτής της προσπάθειας
Η σύνδεση Google δεν είναι διαθέσιμη. Μπορείτε να χρησιμοποιήσετε email και κωδικό.
Αυτή η προσπάθεια έληξε. Ακυρώστε την και ξεκινήστε ξανά.
Αυτός ο λογαριασμός Google συνδέεται ήδη αλλού. Ο τρέχων λογαριασμός και η συνδρομή διατηρούνται.
Η σύνδεση Google απέτυχε. Δοκιμάστε ξανά· η τρέχουσα πρόσβαση διατηρείται.
Το αποτέλεσμα δεν επιβεβαιώθηκε. Ελέγξτε την προσπάθεια ή ακυρώστε την πριν ξεκινήσετε ξανά.
Η ακύρωση δεν επιβεβαιώθηκε. Δοκιμάστε να ακυρώσετε ξανά πριν φύγετε από αυτή την οθόνη.
Η σύνδεση Google ακυρώθηκε.
Επιλέξτε τον λογαριασμό σας Google…
Έλεγχος λογαριασμού…
Το email επιβεβαίωσης δεν στάλθηκε. Δοκιμάστε αργότερα.
Στάλθηκε email επιβεβαίωσης. Ελέγξτε τα εισερχόμενα.
Περιμένετε πριν δοκιμάσετε ξανά.
Ο κωδικός FuzeVPN είναι λανθασμένος. Ο τρέχων λογαριασμός διατηρείται.
Ο κωδικός επιβεβαίωσης δεν είναι έγκυρος ή έχει λήξει.
Η συνεδρία άλλαξε. Ακυρώστε αυτή την προσπάθεια πριν ξεκινήσετε ξανά.
Η απάντηση δεν επικυρώθηκε. Η τρέχουσα πρόσβαση διατηρείται.
Ελέγξτε τη χώρα και τις δύο συγκαταθέσεις.
Επιλέξτε χώρα και αποδεχτείτε τα δύο έγγραφα για να συνεχίσετε.
Απαιτείται επιπλέον έλεγχος ασφαλείας. Η τρέχουσα πρόσβαση διατηρείται.
Ο έλεγχος ασφαλείας δεν είναι διαθέσιμος. Δοκιμάστε αργότερα.''',
}

assert len(KEYS) == 37
assert len(TEXTS) == 30
updates = {}
for language, authored in TEXTS.items():
    texts = authored.splitlines()
    assert len(texts) == len(KEYS), (language, len(texts))
    path = ROOT / f'lib/l10n/translations/{language}.json'
    pack = json.loads(path.read_text(encoding='utf-8-sig'))
    for key, text in zip(KEYS, texts, strict=True):
        assert text.strip()
        pack['arb'][f'google_{key}'] = text
    updates[path] = json.dumps(pack, ensure_ascii=False, indent=2) + '\n'
for path, content in updates.items():
    path.write_text(content, encoding='utf-8')
print('Added 37 authored Google messages to 30 language packs.')
