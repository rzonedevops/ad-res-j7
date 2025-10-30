#!/usr/bin/env python3
"""
Test Suite for Professional Communication Standards
Validates that all content meets truthfulness, sincerity, and professional standards
"""

import unittest
from fact_verification_engine import FactVerificationEngine
from professional_language_validator import ProfessionalLanguageValidator
from strict_evidence_report_generator import StrictEvidenceReportGenerator


class TestProfessionalStandards(unittest.TestCase):
    """Test cases for professional communication standards"""
    
    def setUp(self):
        """Set up test fixtures"""
        self.fact_engine = FactVerificationEngine()
        self.language_validator = ProfessionalLanguageValidator()
        self.evidence_generator = StrictEvidenceReportGenerator()
    
    def test_professional_language_detection(self):
        """Test detection of unprofessional language"""
        
        # Test cases with unprofessional language
        unprofessional_content = """
        The defendant is a liar and a scammer who deliberately deceived investors.
        This outrageous behavior is absolutely despicable and shows malicious intent.
        The corrupt official's actions are shocking and appalling.
        """
        
        analysis = self.fact_engine.analyze_content_for_speculation(unprofessional_content)
        
        # Should detect unprofessional language
        self.assertTrue(analysis['requires_revision'])
        self.assertGreater(len(analysis['unprofessional_language']), 0)
        self.assertLess(analysis['professionalism_score'], 1.0)
    
    def test_professional_alternatives_generation(self):
        """Test generation of professional alternatives"""
        
        unprofessional_text = "The defendant's shocking and outrageous behavior is clearly malicious."
        
        alternatives = self.fact_engine.generate_professional_alternatives(unprofessional_text)
        
        # Should provide professional alternatives
        self.assertGreater(len(alternatives['replacements']), 0)
        
        # Each alternative should be more professional
        for replacement in alternatives['replacements']:
            self.assertIn('alternative', replacement)
            self.assertIn('reason', replacement)
            # Professional alternatives should not contain inflammatory language
            self.assertNotRegex(replacement['alternative'].lower(), r'\b(?:shocking|outrageous|malicious)\b')
    
    def test_evidence_based_validation(self):
        """Test validation of evidence-based statements"""
        
        # Content with proper evidence backing
        evidence_backed_content = """
        According to bank statement dated June 7, 2025, R 500,000 was transferred.
        As documented in court filing page_0025.md, the director's loan was authorized.
        Financial records show R 900,000 in documented transactions.
        """
        
        validation = self.language_validator.validate_content(evidence_backed_content)
        
        # Should have high evidence backing
        self.assertGreater(validation['evidence_backing'], 0.5)
        self.assertGreater(validation['truthfulness_score'], 0.5)
    
    def test_speculation_detection(self):
        """Test detection of speculative language"""
        
        speculative_content = """
        The defendant might have stolen approximately R 250,000,000.
        It appears that the damage could exceed R 500,000 possibly.
        The projected losses are estimated to be around R 1,000,000.
        """
        
        analysis = self.fact_engine.analyze_content_for_speculation(speculative_content)
        
        # Should detect speculation
        self.assertTrue(analysis['requires_revision'])
        self.assertGreater(len(analysis['speculative_language']), 0)
        self.assertLess(analysis['confidence_score'], 1.0)
    
    def test_truthful_content_passes(self):
        """Test that truthful, professional content passes validation"""
        
        professional_content = """
        According to bank statement entry dated June 7, 2025, R 500,000 was transferred to the director.
        Court document page_0025.md documents this transaction as an authorized director's loan.
        Financial records indicate the transfer was processed on July 16, 2025.
        The transaction is recorded in official banking systems with proper authorization.
        """
        
        # Fact verification should pass
        analysis = self.fact_engine.analyze_content_for_speculation(professional_content)
        self.assertFalse(analysis['requires_revision'])
        self.assertEqual(len(analysis['unprofessional_language']), 0)
        
        # Language validation should pass
        validation = self.language_validator.validate_content(professional_content)
        self.assertTrue(validation['is_professional'])
        self.assertGreater(validation['evidence_backing'], 0.6)
    
    def test_neutral_factual_language(self):
        """Test that neutral, factual language is preserved"""
        
        neutral_content = """
        The transaction records indicate non-compliance with standard procedures.
        Actions taken were inconsistent with documented agreements.
        The conduct was inappropriate according to professional standards.
        Records show unauthorized access to financial systems.
        """
        
        validation = self.language_validator.validate_content(neutral_content)
        
        # Should be professional and neutral
        self.assertTrue(validation['is_professional'])
        self.assertEqual(len(validation['violations']), 0)
        self.assertGreater(validation['professionalism_score'], 0.8)
    
    def test_false_accusations_detection(self):
        """Test detection of false accusations without evidence"""
        
        accusatory_content = """
        John deliberately lied to investors and knowingly deceived customers.
        The defendant obviously intended to defraud the company.
        This was clearly a malicious attack designed to destroy the business.
        """
        
        analysis = self.fact_engine.analyze_content_for_speculation(accusatory_content)
        validation = self.language_validator.validate_content(accusatory_content)
        
        # Should detect problems
        self.assertGreater(len(analysis['unprofessional_language']), 0)
        self.assertFalse(validation['is_professional'])
        self.assertGreater(len(validation['violations']), 0)
    
    def test_documented_facts_extraction(self):
        """Test extraction of only documented facts"""
        
        mixed_content = """
        According to invoice #12345, the amount was R 10,000.
        The defendant might have stolen additional funds.
        Bank statement shows R 5,000 transfer on June 1, 2025.
        We estimate total damages could be R 100,000.
        Contract document specifies R 15,000 payment terms.
        """
        
        facts = self.fact_engine.extract_documented_facts(mixed_content)
        
        # Should extract only evidence-backed facts
        self.assertGreater(len(facts), 0)
        
        # Each fact should have evidence backing
        for fact in facts:
            self.assertEqual(fact['evidence_strength'], 'documented')
            self.assertIsNotNone(fact['statement'])
    
    def test_professional_report_generation(self):
        """Test generation of professional standards report"""
        
        test_content = """
        The scammer deliberately lied about the R 250,000,000 in estimated damages.
        According to bank records, R 500,000 was documented as transferred.
        This outrageous behavior is absolutely shocking.
        """
        
        report = self.language_validator.generate_professional_report(test_content, "test_content.md")
        
        # Report should identify issues and provide solutions
        self.assertIn('Professional Communication Standards Report', report)
        self.assertIn('Violations Identified', report)
        self.assertIn('Professional Improvement Suggestions', report)
        self.assertIn('Governing Principles', report)
    
    def test_strict_evidence_standards(self):
        """Test that strict evidence standards are maintained"""
        
        # Create test content with mixed evidence quality
        test_file_content = """
        According to bank statement entry, R 500,000 was recorded on July 16, 2025.
        The estimated damages might be around R 250,000,000.
        Invoice #12345 documents R 10,000 payment dated June 1, 2025.
        """
        
        # Write temporary test file
        test_file_path = "/tmp/test_evidence.md"
        with open(test_file_path, 'w') as f:
            f.write(test_file_content)
        
        try:
            facts = self.evidence_generator.extract_documented_facts(test_file_path)
            
            # Should extract only documented facts, not estimates
            documented_amounts = [f for f in facts if f['type'] == 'documented_amount']
            
            # Should have documented facts but exclude estimates
            self.assertGreater(len(documented_amounts), 0)
            
            # No fact should contain speculative language
            for fact in facts:
                statement = fact['statement'].lower()
                self.assertNotIn('estimated', statement)
                self.assertNotIn('might', statement)
                self.assertNotIn('around', statement)
                
        finally:
            # Clean up test file
            import os
            if os.path.exists(test_file_path):
                os.remove(test_file_path)
    
    def test_core_principles_compliance(self):
        """Test compliance with core principles of truthfulness and professionalism"""
        
        compliant_content = """
        Financial records dated June 7, 2025 document R 500,000 director's loan.
        Court filing page_0025.md confirms authorization for this transaction.
        Bank statement entry shows processing on July 16, 2025.
        Official documentation supports all referenced amounts and dates.
        """
        
        non_compliant_content = """
        The lying defendant stole approximately R 250,000,000 in a shocking scheme.
        This despicable fraud is obviously designed to destroy innocent investors.
        The corrupt officials clearly colluded in this outrageous scam.
        """
        
        # Compliant content should pass all checks
        compliant_analysis = self.fact_engine.analyze_content_for_speculation(compliant_content)
        compliant_validation = self.language_validator.validate_content(compliant_content)
        
        self.assertFalse(compliant_analysis['requires_revision'])
        self.assertTrue(compliant_validation['is_professional'])
        self.assertGreater(compliant_validation['evidence_backing'], 0.4)
        
        # Non-compliant content should fail checks
        non_compliant_analysis = self.fact_engine.analyze_content_for_speculation(non_compliant_content)
        non_compliant_validation = self.language_validator.validate_content(non_compliant_content)
        
        self.assertTrue(non_compliant_analysis['requires_revision'])
        self.assertFalse(non_compliant_validation['is_professional'])
        self.assertGreater(len(non_compliant_analysis['unprofessional_language']), 0)


class TestIntegrationCompliance(unittest.TestCase):
    """Integration tests for complete professional standards compliance"""
    
    def setUp(self):
        """Set up integration test fixtures"""
        self.fact_engine = FactVerificationEngine()
        self.language_validator = ProfessionalLanguageValidator()
    
    def test_complete_professional_workflow(self):
        """Test complete workflow for professional content validation"""
        
        # Sample content that needs revision
        original_content = """
        The defendant is clearly a liar who deliberately stole R 250,000,000.
        This shocking fraud scheme is obviously malicious and despicable.
        Bank records might show some transactions but the estimated damage is huge.
        """
        
        # Step 1: Analyze for issues
        analysis = self.fact_engine.analyze_content_for_speculation(original_content)
        validation = self.language_validator.validate_content(original_content)
        
        # Should identify multiple issues
        self.assertTrue(analysis['requires_revision'])
        self.assertFalse(validation['is_professional'])
        
        # Step 2: Generate professional revision
        revision = self.fact_engine.generate_fact_based_revision(original_content)
        
        # Revision should be professional
        self.assertIn('Fact-Based Analysis Report', revision)
        self.assertIn('Professional Standards', revision)
        
        # Step 3: Validate revision meets standards
        revision_analysis = self.fact_engine.analyze_content_for_speculation(revision)
        
        # Revision should be much more professional (or at least not worse)
        self.assertLessEqual(len(revision_analysis.get('unprofessional_language', [])), 
                            len(analysis['unprofessional_language']))


def run_professional_standards_tests():
    """Run all professional standards tests"""
    
    print("=== RUNNING PROFESSIONAL STANDARDS TESTS ===")
    
    # Create test suite
    suite = unittest.TestSuite()
    
    # Add test classes
    suite.addTest(unittest.makeSuite(TestProfessionalStandards))
    suite.addTest(unittest.makeSuite(TestIntegrationCompliance))
    
    # Run tests
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    # Report results
    print("\n=== TEST RESULTS ===")
    print(f"Tests run: {result.testsRun}")
    print(f"Failures: {len(result.failures)}")
    print(f"Errors: {len(result.errors)}")
    
    if result.failures:
        print("\nFAILURES:")
        for test, traceback in result.failures:
            print(f"- {test}: {traceback}")
    
    if result.errors:
        print("\nERRORS:")
        for test, traceback in result.errors:
            print(f"- {test}: {traceback}")
    
    success = len(result.failures) == 0 and len(result.errors) == 0
    print(f"\n{'✅ ALL TESTS PASSED' if success else '❌ SOME TESTS FAILED'}")
    
    return success


if __name__ == "__main__":
    run_professional_standards_tests()