#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50944 "SCustody Package Register List"
{
    CardPageID = "SCustody Package Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Safe Custody Package Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Package ID"; "Package ID")
                {
                    ApplicationArea = Basic;
                }
                field("Package Type"; "Package Type")
                {
                    ApplicationArea = Basic;
                }
                field("Package Description"; "Package Description")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Custody Period"; "Custody Period")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account"; "Charge Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maturity Instruction"; "Maturity Instruction")
                {
                    ApplicationArea = Basic;
                }
                field("File Serial No"; "File Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received"; "Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Time Received"; "Time Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Lodged By(Custodian 1)"; "Lodged By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Lodged By(Custodian 2)"; "Lodged By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Date Lodged"; "Date Lodged")
                {
                    ApplicationArea = Basic;
                }
                field("Time Lodged"; "Time Lodged")
                {
                    ApplicationArea = Basic;
                }
                field("Released By(Custodian 1)"; "Released By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Released By(Custodian 2)"; "Released By(Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released"; "Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Time Released"; "Time Released")
                {
                    ApplicationArea = Basic;
                }
                field("Collected By"; "Collected By")
                {
                    ApplicationArea = Basic;
                }
                field("Collected On"; "Collected On")
                {
                    ApplicationArea = Basic;
                }
                field("Collected At"; "Collected At")
                {
                    ApplicationArea = Basic;
                }
                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By(Custodian 1)"; "Retrieved By(Custodian 1)")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved By (Custodian 2)"; "Retrieved By (Custodian 2)")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved On"; "Retrieved On")
                {
                    ApplicationArea = Basic;
                }
                field("Retrieved At"; "Retrieved At")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Charge Account Name"; "Charge Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Fee Charged"; "Safe Custody Fee Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Package Re_Booked On"; "Package Re_Booked On")
                {
                    ApplicationArea = Basic;
                }
                field("Package Rebooked By"; "Package Rebooked By")
                {
                    ApplicationArea = Basic;
                }
                field("Package Re_Lodge Fee Charged"; "Package Re_Lodge Fee Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Package Status"; "Package Status")
                {
                    ApplicationArea = Basic;
                }
                field("Package Rebooked On"; "Package Rebooked On")
                {
                    ApplicationArea = Basic;
                }
                field("Package Rebooking Status"; "Package Rebooking Status")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Retrieve Package")
            {
                ApplicationArea = Basic;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Package Retrieval Request List";
            }
        }
    }
}

