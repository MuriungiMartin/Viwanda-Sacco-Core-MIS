#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 10201 "Transfer Custom Fields"
{

    trigger OnRun()
    begin
    end;


    procedure GenJnlLineTOGenLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var GenLedgEntry: Record "G/L Entry")
    begin
    end;


    procedure GenJnlLineTOTaxEntry(var GenJnlLine: Record "Gen. Journal Line"; var TaxEntry: Record "VAT Entry")
    begin
    end;


    procedure GenJnlLineTOCustLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
    end;


    procedure GenJnlLineTOVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
    end;


    procedure GenJnlLineTOBankAccLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var BankAccLedgEntry: Record "Bank Account Ledger Entry")
    begin
    end;


    procedure BankAccLedgEntryTOChkLedgEntry(var BankAccLedgEntry: Record "Bank Account Ledger Entry"; var CheckLedgEntry: Record "Check Ledger Entry")
    begin
    end;


    procedure VendLedgEntryTOCVLedgEntryBuf(var VendLedgEntry: Record "Vendor Ledger Entry"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    begin
    end;


    procedure CVLedgEntryBufTOVendLedgEntry(var CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var VendLedgEntry: Record "Vendor Ledger Entry")
    begin
    end;


    procedure CustLedgEntryTOCVLedgEntryBuf(var CustLedgEntry: Record "Cust. Ledger Entry"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    begin
    end;


    procedure CVLedgEntryBufTOCustLedgEntry(var CVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
    end;


    procedure ItemJnlLineTOItemLedgEntry(var ItemJnlLine: Record "Item Journal Line"; var ItemLedgEntry: Record "Item Ledger Entry")
    begin
    end;


    procedure ItemJnlLineTOPhysInvtLedgEntry(var ItemJnlLine: Record "Item Journal Line"; var PhysInvtLedgEntry: Record "Phys. Inventory Ledger Entry")
    begin
    end;


    procedure ItemJnlLineTOValueEntry(var ItemJnlLine: Record "Item Journal Line"; var ValueEntry: Record "Value Entry")
    begin
    end;


    procedure JobJnlLineTOResJnlLine(var JobJnlLine: Record "Job Journal Line"; var ResJnlLine: Record "Res. Journal Line")
    begin
    end;


    procedure JobJnlLineTOItemJnlLine(var JobJnlLine: Record "Job Journal Line"; var ItemJnlLine: Record "Item Journal Line")
    begin
    end;


    procedure JobJnlLineTOGenJnlLine(var JobJnlLine: Record "Job Journal Line"; var GenJnlLine: Record "Gen. Journal Line")
    begin
    end;


    procedure JobJnlLineTOJobLedgEntry(var JobJnlLine: Record "Job Journal Line"; var JobLedgEntry: Record "Job Ledger Entry")
    begin
    end;


    procedure ResJnlLineTOResLedgEntry(var ResJnlLine: Record "Res. Journal Line"; var ResLedgEntry: Record "Res. Ledger Entry")
    begin
    end;


    procedure GenJnlLineTOMembLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var MembLedgEntry: Record "Member Ledger Entry")
    begin
    end;


    procedure MembLedgEntryTOCVLedgEntryBuf(var MembLedgEntry: Record "Member Ledger Entry"; var CVLedgEntryBuf: Record "CV Ledger Entry Buffer")
    begin
    end;
}

