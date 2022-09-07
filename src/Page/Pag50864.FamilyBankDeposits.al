#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50864 "Family Bank Deposits"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "FB Cash Deposit";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No"; "Transaction No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field(Reference; Reference)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; "Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Inst Account"; "Inst Account")
                {
                    ApplicationArea = Basic;
                }
                field(Msisdn; Msisdn)
                {
                    ApplicationArea = Basic;
                }
                field(Narration; Narration)
                {
                    ApplicationArea = Basic;
                }
                field("Inst Name"; "Inst Name")
                {
                    ApplicationArea = Basic;
                }
                field("Flex Trans Serial No"; "Flex Trans Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Fetch Date"; "Fetch Date")
                {
                    ApplicationArea = Basic;
                }
                field(Channel; Channel)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date posted"; "Date posted")
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

