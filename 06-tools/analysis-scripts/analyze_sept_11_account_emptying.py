#!/usr/bin/env python3
"""
September 11, 2025 Account Emptying Analysis
Calculating total amount emptied across all accounts on Kayla's birthday
"""

# Data extracted from bank statements (September 11, 2025)
accounts = [
    {
        "name": "RegimA Skin Savings Account",
        "account_number": "62134839127",
        "type": "Money Market Transactor",
        "transfer_out": 3090000.00,
        "balance_after": 4822294.91,
        "description": "INTERNET TRF FROM TRF TO SAVINGS ACCOU"
    },
    {
        "name": "Strategic Savings Acc",
        "account_number": "62593375829",
        "type": "Money on Call",
        "transfer_out": 640000.00,
        "balance_after": 1210093.45,
        "description": "INTERNET TRF FROM TRF TO SAVINGS ACCOU"
    },
    {
        "name": "Strategic Main Account",
        "account_number": "62432501494",
        "type": "Platinum Business Account",
        "transfer_out": 640000.00,
        "balance_after": 11960.88,
        "description": "TRF TO SAVINGS ACCOU"
    },
    {
        "name": "Villa Via Savings Acc",
        "account_number": "62812835744",
        "type": "Money on Call",
        "transfer_out": 1730000.00,
        "balance_after": 2484289.09,
        "description": "INTERNET TRF FROM TRF TO SAVINGS ACCOU"
    },
    {
        "name": "RegimA Skin Main Account",
        "account_number": "55270035642",
        "type": "Platinum Business Account",
        "transfer_out": 3090000.00,
        "balance_after": 9140.90,
        "description": "TRF TO SAVINGS ACCOU"
    },
    {
        "name": "RegimA Wwd Main Account",
        "account_number": "62323196362",
        "type": "Platinum Business Account",
        "transfer_out": 5164131.18,
        "balance_after": 3978.81,
        "description": "TRANSFER SAVINGS"
    },
    {
        "name": "Villa Via Main Account",
        "account_number": "62423540807",
        "type": "Platinum Business Account",
        "transfer_out": 1730000.00,
        "balance_after": 15329.68,
        "description": "TRF TO SAVINGS ACCOU"
    }
]

print("=" * 100)
print("SEPTEMBER 11, 2025 ACCOUNT EMPTYING ANALYSIS")
print("KAYLA'S BIRTHDAY - THE FORCED FAILURE")
print("=" * 100)
print()

print("ACCOUNT-BY-ACCOUNT BREAKDOWN")
print("-" * 100)
print(f"{'Account Name':<35} {'Account Number':<20} {'Amount Emptied':<20} {'Balance After':<20}")
print("-" * 100)

total_emptied = 0.0
for acc in accounts:
    total_emptied += acc["transfer_out"]
    print(f"{acc['name']:<35} {acc['account_number']:<20} R {acc['transfer_out']:>15,.2f}  R {acc['balance_after']:>15,.2f}")

print("-" * 100)
print(f"{'TOTAL EMPTIED ON SEPTEMBER 11, 2025:':<55} R {total_emptied:>15,.2f}")
print("=" * 100)
print()

print("CRITICAL OBSERVATIONS")
print("-" * 100)
print("1. DATE SIGNIFICANCE:")
print("   - September 11, 2025 = Kayla's birthday")
print("   - 4th birthday attack (after Jacqui, Kayla, Daniel)")
print("   - Forced failure on most emotionally devastating date")
print()

print("2. PATTERN OF EMPTYING:")
print("   - ALL business accounts emptied to near-ZERO balances")
print("   - Strategic Main Account: R 640k → R 11,960.88 (98.1% emptied)")
print("   - RegimA Skin Main: R 3.09M → R 9,140.90 (99.7% emptied)")
print("   - RegimA Wwd Main: R 5.16M → R 3,978.81 (99.9% emptied)")
print("   - Villa Via Main: R 1.73M → R 15,329.68 (99.1% emptied)")
print()

print("3. TRANSFER MECHANISM:")
print("   - All transfers described as 'TRF TO SAVINGS ACCOU' or 'TRANSFER SAVINGS'")
print("   - Coordinated simultaneous transfers across 7 accounts")
print("   - Executed on same day (September 11, 2025)")
print()

print("4. FORCED INSOLVENCY FORMULA:")
print("   - ZERO REVENUE (93.3% drop from May 2025)")
print("   - + ALL LIABILITIES (R 16.08M emptied)")
print("   - = FORCED INSOLVENCY")
print()

print("5. COMPARISON TO PREVIOUS ANALYSIS:")
print(f"   - Previous estimate: R 12M")
print(f"   - Actual total: R {total_emptied:,.2f}")
print(f"   - Difference: R {total_emptied - 12000000:,.2f} ({((total_emptied - 12000000) / 12000000 * 100):.1f}% higher)")
print()

print("=" * 100)
print("CONCLUSION")
print("=" * 100)
print()
print(f"On September 11, 2025 (Kayla's birthday), R {total_emptied:,.2f} was systematically")
print("emptied from 7 business accounts, leaving them with near-ZERO balances.")
print()
print("This was the FINAL PRONG of the 9-prong coordinated attack:")
print("- Prong 1-2: Revenue hijacking (March-May 2025)")
print("- Prong 3: Data theft (May 22, 2025)")
print("- Prong 4: Card cancellations (June 7, 2025)")
print("- Prong 5-6: Client diversion (June 20, 2025)")
print("- Prong 7: UK payment disruption (July 10, 2025)")
print("- Prong 8: ACCOUNT EMPTYING (September 11, 2025) ← THIS EVENT")
print("- Prong 9: Curatorship application (forced failure)")
print()
print("Formula: ZERO REVENUE + ALL LIABILITIES = FORCED INSOLVENCY")
print()
print("=" * 100)
