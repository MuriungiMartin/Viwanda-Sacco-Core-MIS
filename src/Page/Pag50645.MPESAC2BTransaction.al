#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50645 "MPESA C2B Transaction"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = MPESAC2BTransactions;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ColumnID; ColumnID)
                {
                    ApplicationArea = Basic;
                }
                field(ReceiptNumber; ReceiptNumber)
                {
                    ApplicationArea = Basic;
                }
                field(CustomerName; CustomerName)
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNumber; PhoneNumber)
                {
                    ApplicationArea = Basic;
                }
                field(AccountNumber; AccountNumber)
                {
                    ApplicationArea = Basic;
                }
                field(TrxAmount; TrxAmount)
                {
                    ApplicationArea = Basic;
                }
                field(TrxStatus; TrxStatus)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Validated; Validated)
                {
                    ApplicationArea = Basic;
                }
                field(DateValidated; DateValidated)
                {
                    ApplicationArea = Basic;
                }
                field(DateCompleted; DateCompleted)
                {
                    ApplicationArea = Basic;
                }
                field("Un Identified Payments"; "Un Identified Payments")
                {
                    ApplicationArea = Basic;
                }
                field(TrxDetails; TrxDetails)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; DatePosted)
                {
                    ApplicationArea = Basic;
                }
                field(Alerted; Alerted)
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Un Identified Payment Posted"; "Un Identified Payment Posted")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

