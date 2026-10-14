# SPDX-License-Identifier: Apache-2.0
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

SPEC = importlib.util.spec_from_file_location('qualification', Path(__file__).parents[1]/'check_validation.py')
qualification = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(qualification)

class QualificationEvidenceTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        (self.root/'docs/validation-evidence').mkdir(parents=True)
        (self.root/'README.md').write_text('fixture', encoding='utf-8')
        package = {'SPDXID':'SPDXRef-Test', 'licenseDeclared':'MIT', 'licenseConcluded':'NOASSERTION'}
        (self.root/'docs/SBOM.spdx.json').write_text(json.dumps({'packages':[package]}), encoding='utf-8')
        (self.root/'docs/validation-evidence/licenses.json').write_text(json.dumps({'packages':[{'id':'SPDXRef-Test','licenseDeclared':'MIT','licenseConcluded':'NOASSERTION','reason':'Aggregate conclusion unavailable','remaining_unknown_fields':{'licenseConcluded':'Mixed components'}}]}), encoding='utf-8')
        self.payload = {'id':'E1','kind':'instrumentation','artifacts':['apk-74016'],'artifact_sha256':{'apk-74016':'a'*64},'test_counts':{'total':2,'passed':1,'failures':0,'errors':0,'skipped':1}}
        self.registry = {'schema':1,'artifacts':{'apk-74016':{'version':'0.2.10+74016','sha256':'a'*64},'apk-old':{'version':'74008','sha256':'b'*64}},'evidence':[], 'items':[{'id':'Q001','claim':'Test claim','verdict':'validated','date':'2026-10-14','environment':'isolated VM','method':'instrumentation','result':'One executed test passed; another was skipped','scope':'VM only','artifacts':['apk-74016'],'evidence':['E1'],'documents':['README.md']}], 'inventory':[{'path':'README.md','line':1,'original_text':'not attested','items':['Q001']}]}
        self.write_evidence()

    def write_evidence(self):
        path = self.root/'docs/validation-evidence/e1.json'
        path.write_text(json.dumps(self.payload), encoding='utf-8')
        self.registry['evidence'] = [{'id':'E1','path':'docs/validation-evidence/e1.json','kind':self.payload['kind'],'artifacts':self.payload['artifacts'],'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}]

    def errors(self):
        return qualification.validate(self.root, self.registry)

    def test_accepts_scoped_evidence_with_skipped_tests_separately_counted(self):
        self.assertEqual([], self.errors())

    def test_rejects_validated_claim_without_evidence(self):
        self.registry['items'][0]['evidence'] = []
        self.assertTrue(any('without evidence' in e for e in self.errors()))

    def test_rejects_historical_apk_evidence_for_current_apk(self):
        self.payload['artifacts'] = ['apk-old']
        self.payload['artifact_sha256'] = {'apk-old':'b'*64}
        self.write_evidence()
        self.assertTrue(any('wrong APK/version' in e for e in self.errors()))

    def test_rejects_wrong_apk_fingerprint_even_with_correct_label(self):
        self.payload['artifact_sha256']['apk-74016'] = 'b'*64
        self.write_evidence()
        self.assertTrue(any('wrong APK or artifact hash' in e for e in self.errors()))

    def test_rejects_skipped_test_counted_as_passed(self):
        self.payload['test_counts']['passed'] = 2
        self.write_evidence()
        self.assertTrue(any('ignored/failed tests counted as passed' in e for e in self.errors()))

    def test_rejects_evidence_changed_after_hash_registration(self):
        (self.root/'docs/validation-evidence/e1.json').write_text(json.dumps(dict(self.payload, extra=True)), encoding='utf-8')
        self.assertTrue(any('hash mismatch' in e for e in self.errors()))

    def test_rejects_unmapped_reservation(self):
        self.registry['inventory'][0]['items'] = []
        self.assertTrue(any('reservation without verdict' in e for e in self.errors()))

    def test_rejects_unexplained_license_unknown(self):
        path = self.root/'docs/validation-evidence/licenses.json'
        value = json.loads(path.read_text(encoding='utf-8'))
        value['packages'][0]['remaining_unknown_fields'] = {}
        path.write_text(json.dumps(value), encoding='utf-8')
        self.assertTrue(any('unexplained NOASSERTION' in e for e in self.errors()))

    def test_rejects_private_host_path(self):
        self.payload['source'] = r'C:\Users\account\private-report.json'
        self.write_evidence()
        self.assertTrue(any('private host path' in e for e in self.errors()))

    def test_rejects_duplicate_qualification(self):
        self.registry['items'].append(copy.deepcopy(self.registry['items'][0]))
        self.assertTrue(any('Duplicate item' in e for e in self.errors()))

    def test_checks_local_markdown_links(self):
        (self.root/'README.md').write_text('[report](docs/missing.md)', encoding='utf-8')
        self.assertTrue(any('broken local link' in e for e in qualification.check_markdown_links(self.root)))

if __name__ == '__main__':
    unittest.main()
