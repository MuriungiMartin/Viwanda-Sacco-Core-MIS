#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50947 "Post Package Rebookings"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Safe Custody Package Register"; "Safe Custody Package Register")
        {
            DataItemTableView = where("Package Status" = filter(<> Released));
            RequestFilterFields = "Package ID";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if ("Maturity Date" <= WorkDate) and ("Maturity Date" < 0D) and ("Package Status" <> "package status"::Released) then begin

                    JTemplate := 'GENERAL';
                    JBatch := 'SCUSTODY';
                    DocNo := SFactory.FnRunGetNextTransactionDocumentNo;


                    AvailableBal := SFactory.FnRunGetAccountAvailableBalanceWithoutFreeze("Charge Account", WorkDate);
                    ObjPackageTypes.Reset;
                    ObjPackageTypes.SetRange(ObjPackageTypes.Code, "Package Type");
                    if ObjPackageTypes.FindSet then begin
                        LodgeFee := ObjPackageTypes."Package Charge";
                        LodgeFeeAccount := ObjPackageTypes."Package Charge Account";
                    end;
                    GenSetup.Get();
                    if AvailableBal >= (LodgeFee + (LodgeFee * (GenSetup."Excise Duty(%)" / 100))) then begin

                        //=============================================================================Lodge Fee
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Charge Account", WorkDate, 'Rebooking Safe Custody',
                        GenJournalLine."bal. account type"::"G/L Account", LodgeFeeAccount, LodgeFee, 'BOSA', '');

                        GenSetup.Get();
                        ExciseDuty := (LodgeFee * (GenSetup."Excise Duty(%)" / 100));
                        ExciseDutyAccount := GenSetup."Excise Duty Account";

                        GenSetup.Get();
                        //=============================================================================Excise On Lodge Fee
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLineBalanced(JTemplate, JBatch, DocNo, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, "Charge Account", Today, 'Tax:Rebooking Safe Custody',
                        GenJournalLine."bal. account type"::"G/L Account", ExciseDutyAccount, ExciseDuty, 'BOSA', '');



                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'SCUSTODY');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        "Maturity Date" := CalcDate("Custody Period", "Maturity Date");
                        "Package Rebooked On" := WorkDate;
                        "Package Rebooking Status" := "package rebooking status"::Succesful;
                        Modify;
                    end else
                        if AvailableBal < (LodgeFee + (LodgeFee * (GenSetup."Excise Duty(%)" / 100))) then begin
                            "Package Rebooking Status" := "package rebooking status"::"Not Succesful";
                            Modify;
                        end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name", 'SCUSTODY');
                if GenJournalLine.Find('-') then begin
                    GenJournalLine.DeleteAll;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ObjGensetup: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[30];
        BATCH_NAME: Code[30];
        DOCUMENT_NO: Code[30];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarShareCapVariance: Decimal;
        VarAmountPosted: Decimal;
        VarBenfundVariance: Decimal;
        VarDepositBufferEntryNo: Integer;
        VarMonthlyContribution: Decimal;
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        ObjPackageTypes: Record "Package Types";
        LodgeFee: Decimal;
        LodgeFeeAccount: Code[20];
        GenSetup: Record "Sacco General Set-Up";
        SurestepFactory: Codeunit "SURESTEP Factory";
        JTemplate: Code[30];
        JBatch: Code[30];
        DocNo: Code[30];
        ExciseDuty: Decimal;
        ExciseDutyAccount: Code[20];
}

