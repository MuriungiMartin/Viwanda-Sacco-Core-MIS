#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50367 "Member Account Card"
{
    Caption = 'Member Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Customer;
    SourceTableView = sorting("Employer Code")
                      where(ISNormalMember = filter(true));

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                Editable = true;
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Category';
                    Editable = false;
                }
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                    Editable = false;
                }
                field("Joint Account Name"; "Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Application No."; "Application No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Standing Order No"; "Standing Order No")
                {
                    ApplicationArea = Basic;
                }
                field("Identification Document"; "Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID Number';
                    Editable = false;
                }
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Pin; Pin)
                {
                    ApplicationArea = Basic;
                    Caption = 'KRA PIN';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Secondary Phone No';
                    Editable = false;
                }
                field(txtMarital; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                    Visible = txtMaritalVisible;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Country';
                    Editable = false;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(County; County)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    TableRelation = Counties."County Name";
                }
                field(District; District)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Location"; "Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member's Residence"; "Member's Residence")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                    Editable = false;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code';
                    Editable = false;
                }
                field(Town; Town)
                {
                    ApplicationArea = Basic;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Payment Date"; "Last Payment Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Action On Dividend Earned"; "Action On Dividend Earned")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Status';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Overide Defaulters");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                    Caption = 'Blocked Status';
                    Editable = false;
                }
                field(Disabled; Disabled)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(rejoined; rejoined)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reactivated';
                    Editable = false;
                }
                field("Rejoining Date"; "Rejoining Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reactivation Date';
                    Editable = false;
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Insider Status"; "Insider Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Online Member"; "Online Member")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("KYC Completed"; "KYC Completed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Block Mobile Loan"; "Block Mobile Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Block MBanking Loan Application';

                    trigger OnValidate()
                    begin
                        if "Block Mobile Loan" = false then begin
                            UserSetup.Reset;
                            UserSetup.SetRange(UserSetup."User ID", UserId);
                            UserSetup.SetRange(UserSetup."Unblock Loan Application", false);
                            if UserSetup.FindSet then
                                Error('You are not authorized to unblock a Member for Loan Application');
                        end;
                    end;
                }
                field("Block Normal Loan"; "Block Normal Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Block Manual Loan Application';

                    trigger OnValidate()
                    begin
                        if "Block Normal Loan" = false then begin
                            UserSetup.Reset;
                            UserSetup.SetRange(UserSetup."User ID", UserId);
                            UserSetup.SetRange(UserSetup."Unblock Loan Application", false);
                            if UserSetup.FindSet then
                                Error('You are not authorized to unblock a Member for Loan Application');
                        end;
                    end;
                }
            }
            group("Bank Details")
            {
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch Code"; "Bank Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch Name"; "Bank Branch Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Contact Info")
            {
                Caption = 'Contact Info';
                Editable = true;
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Indemnified"; "Email Indemnified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Page"; "Home Page")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Address"; "Home Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Postal Code"; "Home Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contact Person Phone"; "Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                Editable = false;
                field("Occupation Details"; "Occupation Details")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        EmployedVisible := false;
                        SelfEmployedVisible := false;
                        OtherVisible := false;

                        if ("Occupation Details" = "occupation details"::Employed) or ("Occupation Details" = "occupation details"::"Employed & Self Employed") then begin
                            EmployedVisible := true;
                        end;

                        if ("Occupation Details" = "occupation details"::"Self-Employed") or ("Occupation Details" = "occupation details"::"Employed & Self Employed") then begin
                            SelfEmployedVisible := true;
                        end;

                        if ("Occupation Details" = "occupation details"::Others) or ("Occupation Details" = "occupation details"::Contracting) then begin
                            OtherVisible := true;
                        end;



                        /*IF "Identification Document"="Identification Document"::"Nation ID Card" THEN BEGIN
                          PassportEditable:=FALSE;
                          IDNoEditable:=TRUE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Passport Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=FALSE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Aliens Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=TRUE;
                        END;
                        */

                    end;
                }
                group(Employed)
                {
                    Caption = 'Employment Details';
                    Visible = EmployedVisible;
                    field("Employer Code"; "Employer Code")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Employer Name"; "Employer Name")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Employer Address"; "Employer Address")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Member Payment Type"; "Member Payment Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Terms Of Employment"; "Terms Of Employment")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Date of Employment"; "Date of Employment")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Position Held"; "Position Held")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Expected Monthly Income"; "Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Monthly Income Bracket';
                }
                field("Expected Monthly Income Amount"; "Expected Monthly Income Amount")
                {
                    ApplicationArea = Basic;
                }
                group(SelfEmployed)
                {
                    Caption = 'Self_Employment Details';
                    Visible = SelfEmployedVisible;
                    field("Nature Of Business"; "Nature Of Business")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Industry; Industry)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Business Name"; "Business Name")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Physical Business Location"; "Physical Business Location")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Year of Commence"; "Year of Commence")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Other)
                {
                    Caption = 'Details';
                    Visible = OtherVisible;
                    field("Others Details"; "Others Details")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Other Occupation Details';
                    }
                }
            }
            group("Referee Details")
            {
                field("Referee Member No"; "Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Name"; "Referee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee ID No"; "Referee ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Mobile Phone No"; "Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Member Risk Rating")
            {
                Editable = false;
                group("Member Risk Rate")
                {
                    field("Individual Category"; "Individual Category")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Member Residency Status"; "Member Residency Status")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Entities; Entities)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Industry Type"; "Industry Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Length Of Relationship"; "Length Of Relationship")
                    {
                        ApplicationArea = Basic;
                    }
                    field("International Trade"; "International Trade")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Product Risk Rating")
                {
                    field("Electronic Payment"; "Electronic Payment")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Accounts Type Taken"; "Accounts Type Taken")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cards Type Taken"; "Cards Type Taken")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Others(Channels)"; "Others(Channels)")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Member Risk Level"; "Member Risk Level")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Risk Level';
                        Editable = false;
                        // Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; "Due Diligence Measure")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        ///   Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }
                part(Control39; "Member Due Diligence Measure")
                {
                    Caption = 'Due Diligence Measure';
                    SubPageLink = "Member No" = field("No.");
                    SubPageView = sorting("Due Diligence No");
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address3; Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 2"; "Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 2"; "Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. Three"; "Mobile No. Three")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth2"; "Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("ID No.2"; "ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 2"; "Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field(Gender2; Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status2"; "Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code2"; "Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town2"; "Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code2"; "Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name2"; "Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal2)"; "E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                    Editable = false;
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("Name 3"; "Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address4; Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 3"; "Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 3"; "Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 4"; "Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth3"; "Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("ID No.3"; "ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 3"; "Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field(Gender3; Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status3"; "Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code3"; "Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town3"; "Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code3"; "Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name3"; "Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal3)"; "E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("File Movement Tracker")
            {
                Caption = 'File Movement Tracker';
                field(Filelocc; Filelocc)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current File Location';
                    Editable = false;
                }
                field("Loc Description"; "Loc Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Move to"; "Move to")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dispatch to:';
                }
                field("Move to description"; "Move to description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(User; User)
                {
                    ApplicationArea = Basic;
                }
                field("Folio Number"; "Folio Number")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks"; "File Movement Remarks")
                {
                    ApplicationArea = Basic;
                }
                field("File MVT User ID"; "File MVT User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File MVT Date"; "File MVT Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File MVT Time"; "File MVT Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("file Received"; "file Received")
                {
                    ApplicationArea = Basic;
                    Caption = 'File Received';
                    Editable = false;
                }
                field("file received date"; "file received date")
                {
                    ApplicationArea = Basic;
                    Caption = 'File received date';
                    Editable = false;
                }
                field("File received Time"; "File received Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("File Received by"; "File Received by")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("No Of Days"; "No Of Days")
                {
                    ApplicationArea = Basic;
                    Caption = 'No of Days in Current Locaton';
                    Editable = false;
                }
                field("Reason for file overstay"; "Reason for file overstay")
                {
                    ApplicationArea = Basic;
                }
                field("File Movement Remarks1"; "File Movement Remarks1")
                {
                    ApplicationArea = Basic;
                    Caption = 'File MV General Remarks';
                }
            }
            group("Withdrawal Details")
            {
                Caption = 'Withdrawal Details';
                field("Withdrawal Application Date"; "Withdrawal Application Date")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if Confirm('Confirm this Application placement?', false) = true then begin
                            "Exit Application Done By" := UserId;
                            "Exit Application Done On" := Today;
                        end;
                    end;
                }
                field("Reason For Membership Withdraw"; "Reason For Membership Withdraw")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reason For Withdrawal';
                }
                field("Withdrawal Date"; "Withdrawal Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Withdrawal Fee"; "Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Status - Withdrawal App."; "Status - Withdrawal App.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawal Status';
                    Editable = false;
                }
                field("Exit Application Done By"; "Exit Application Done By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Exit Application Done On"; "Exit Application Done On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000107; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000106; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = Card;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    Visible = false;
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ShowContact;
                    end;
                }
                action("Go to FOSA Accounts")
                {
                    ApplicationArea = Basic;
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("No.");
                    Visible = false;
                }
            }
            group(ActionGroup1102755023)
            {
                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories Details';
                    Image = CustomerContact;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Agent Account list";
                    RunPageLink = "Account No" = field("No.");
                    Visible = false;
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Details';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(50503, true, false, Cust);
                    end;
                }
                action("Member is  Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is  Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(50504, true, false, Cust);
                    end;
                }
                action("Create Withdrawal Application")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to create a Withdrawal Application for this Member', false) = true then begin
                            SurestepFactory.FnCreateMembershipWithdrawalApplication("No.", "Withdrawal Application Date", "Reason For Membership Withdraw", "Withdrawal Date");
                        end;
                    end;
                }
                action("Member Risk Ratings")
                {
                    ApplicationArea = Basic;
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Individual Member Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin
                        /*//Risk Rating Options Default
                        ObjMembershipApp.RESET;
                        ObjMembershipApp.SETRANGE(ObjMembershipApp."Assigned No.","No.");
                        IF ObjMembershipApp.FINDSET THEN
                          BEGIN
                          "Electronic Payment":=ObjMembershipApp."Electronic Payment";
                          "Cards Type Taken":=ObjMembershipApp."Cards Type Taken";
                          "Others(Channels)":=ObjMembershipApp."Others(Channels)";
                          "Individual Category":=ObjMembershipApp."Individual Category";
                          "Member Residency Status":=ObjMembershipApp."Member Residency Status";
                          "Industry Type":=ObjMembershipApp."Industry Type";
                          "Length Of Relationship":=ObjMembershipApp."Length Of Relationship";
                          Entities:=ObjMembershipApp.Entities;
                          END;
                        */

                        SFactory.FnGetMemberAMLRiskRating("No.");

                    end;
                }
                action("Account Statement Transactions ")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Statement Buffe";
                    RunPageLink = "Loan No" = field("No.");
                }
                action("Member Deposit Saving History")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Deposit Saving History";
                    RunPageLink = "Loan No" = field("No.");
                }
                action("Load Account Statement Details")
                {
                    ApplicationArea = Basic;
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
                        ObjStatementB: Record "Loan Appraisal Statement Buffe";
                        StatementStartDate: Date;
                        StatementDateFilter: Date;
                        StatementEndDate: Date;
                        VerStatementAvCredits: Decimal;
                        VerStatementsAvDebits: Decimal;
                        VerMonth1Date: Integer;
                        VerMonth1Month: Integer;
                        VerMonth1Year: Integer;
                        VerMonth1StartDate: Date;
                        VerMonth1EndDate: Date;
                        VerMonth1DebitAmount: Decimal;
                        VerMonth1CreditAmount: Decimal;
                        VerMonth2Date: Integer;
                        VerMonth2Month: Integer;
                        VerMonth2Year: Integer;
                        VerMonth2StartDate: Date;
                        VerMonth2EndDate: Date;
                        VerMonth2DebitAmount: Decimal;
                        VerMonth2CreditAmount: Decimal;
                        VerMonth3Date: Integer;
                        VerMonth3Month: Integer;
                        VerMonth3Year: Integer;
                        VerMonth3StartDate: Date;
                        VerMonth3EndDate: Date;
                        VerMonth3DebitAmount: Decimal;
                        VerMonth3CreditAmount: Decimal;
                        VerMonth4Date: Integer;
                        VerMonth4Month: Integer;
                        VerMonth4Year: Integer;
                        VerMonth4StartDate: Date;
                        VerMonth4EndDate: Date;
                        VerMonth4DebitAmount: Decimal;
                        VerMonth4CreditAmount: Decimal;
                        VerMonth5Date: Integer;
                        VerMonth5Month: Integer;
                        VerMonth5Year: Integer;
                        VerMonth5StartDate: Date;
                        VerMonth5EndDate: Date;
                        VerMonth5DebitAmount: Decimal;
                        VerMonth5CreditAmount: Decimal;
                        VerMonth6Date: Integer;
                        VerMonth6Month: Integer;
                        VerMonth6Year: Integer;
                        VerMonth6StartDate: Date;
                        VerMonth6EndDate: Date;
                        VerMonth6DebitAmount: Decimal;
                        VerMonth6CreditAmount: Decimal;
                        VarMonth1Datefilter: Text;
                        VarMonth2Datefilter: Text;
                        VarMonth3Datefilter: Text;
                        VarMonth4Datefilter: Text;
                        VarMonth5Datefilter: Text;
                        VarMonth6Datefilter: Text;
                        ObjMemberCellG: Record "Member House Groups";
                        TrunchDetailsVisible: Boolean;
                        ObjTranch: Record "Tranch Disburesment Details";
                        GenSetUp: Record "Sacco General Set-Up";
                    begin
                        //Clear Buffer
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "No.");
                        if ObjStatementB.FindSet then begin
                            ObjStatementB.DeleteAll;
                        end;



                        //Initialize Variables
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;


                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        GenSetUp.Get();

                        //Month 1
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth1Date := Date2dmy(StatementStartDate, 1);
                        VerMonth1Month := Date2dmy(StatementStartDate, 2);
                        VerMonth1Year := Date2dmy(StatementStartDate, 3);


                        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
                        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

                        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth1EndDate;
                            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
                            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
                            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;


                        //Month 2
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth2Date := Date2dmy(StatementStartDate, 1);
                        VerMonth2Month := (VerMonth1Month + 1);
                        VerMonth2Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth2Month > 12 then begin
                            VerMonth2Month := VerMonth2Month - 12;
                            VerMonth2Year := VerMonth2Year + 1;
                        end;

                        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
                        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
                        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth2EndDate;
                            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
                            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
                            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;

                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        //Month 3
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth3Date := Date2dmy(StatementStartDate, 1);
                        VerMonth3Month := (VerMonth1Month + 2);
                        VerMonth3Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth3Month > 12 then begin
                            VerMonth3Month := VerMonth3Month - 12;
                            VerMonth3Year := VerMonth3Year + 1;
                        end;

                        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
                        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
                        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth3EndDate;
                            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
                            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
                            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 4
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth4Date := Date2dmy(StatementStartDate, 1);
                        VerMonth4Month := (VerMonth1Month + 3);
                        VerMonth4Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth4Month > 12 then begin
                            VerMonth4Month := VerMonth4Month - 12;
                            VerMonth4Year := VerMonth4Year + 1;
                        end;

                        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
                        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
                        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth4EndDate;
                            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
                            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
                            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 5
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth5Date := Date2dmy(StatementStartDate, 1);
                        VerMonth5Month := (VerMonth1Month + 4);
                        VerMonth5Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth5Month > 12 then begin
                            VerMonth5Month := VerMonth5Month - 12;
                            VerMonth5Year := VerMonth5Year + 1;
                        end;

                        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
                        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
                        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth5EndDate;
                            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
                            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
                            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 6
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth6Date := Date2dmy(StatementStartDate, 1);
                        VerMonth6Month := (VerMonth1Month + 5);
                        VerMonth6Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth6Month > 12 then begin
                            VerMonth6Month := VerMonth6Month - 12;
                            VerMonth6Year := VerMonth6Year + 1;
                        end;

                        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
                        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
                        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat

                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth6EndDate;
                            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
                            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
                            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Get Statement Avarage Credits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementAvCredits := VerStatementAvCredits + ObjStatementB."Amount In";
                            //"Bank Statement Avarage Credits":=VerStatementAvCredits/6;
                            //MODIFY/
                            until ObjStatementB.Next = 0;
                        end;

                        //Get Statement Avarage Debits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementsAvDebits := VerStatementsAvDebits + ObjStatementB."Amount Out";
                            //"Bank Statement Avarage Debits":=VerStatementsAvDebits/6;
                            //MODIFY;
                            until ObjStatementB.Next = 0;
                        end;

                        //"Bank Statement Net Income":="Bank Statement Avarage Credits"-"Bank Statement Avarage Debits";
                        //MODIFY;
                    end;
                }
                action("Member Case History")
                {
                    ApplicationArea = Basic;
                    Image = Reconcile;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Case History";
                    RunPageLink = "Member No." = field("No.");
                }
                action("CRB Query Charge")
                {
                    ApplicationArea = Basic;
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "CRB Check Charge List";
                    RunPageLink = "Member No" = field("No.");
                }
                group(Reports)
                {
                    Caption = 'Reports';
                }
                action("Detailed Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;
                        end;

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(50886, true, false, Cust);
                    end;
                }
                action("Loan Statement BOSA")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(50531, true, false, Cust);
                    end;
                }
                action("Member Deposit Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(50354, true, false, Cust);
                    end;
                }
                action("Detailed Interest Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Interest Statement';
                    Image = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Loan Statement FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Statement FOSA';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(50533, true, false, Cust);

                        /*
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(50474,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("FOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "FOSA Account No.");
                        if Vend.Find('-') then begin
                            Report.Run(50890, true, false, Vend);
                        end;


                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."FOSA Account No.","FOSA Account No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(50890,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Group Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'House Group Statement';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", "Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.Run(50920, true, false, ObjCellGroups);
                    end;
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Visible = false;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(50474, true, false, Cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FosaName := '';

        if "FOSA Account No." <> '' then begin
            if Vend.Get("FOSA Account No.") then begin
                FosaName := Vend.Name;
            end;
        end;

        lblIDVisible := true;
        lblDOBVisible := true;
        lblRegNoVisible := false;
        lblRegDateVisible := false;
        lblGenderVisible := true;
        txtGenderVisible := true;
        lblMaritalVisible := true;
        txtMaritalVisible := true;

        if "Account Category" <> "account category"::Individual then begin
            lblIDVisible := false;
            lblDOBVisible := false;
            lblRegNoVisible := true;
            lblRegDateVisible := true;
            lblGenderVisible := false;
            txtGenderVisible := false;
            lblMaritalVisible := false;
            txtMaritalVisible := false;

        end;
        OnAfterGetCurrRecords();

        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User ID", UserId);
        Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
        if not Statuschange.Find('-') then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;
        if "Account Category" <> "account category"::Corporate then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if "Account Category" <> "account category"::Corporate then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;

        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if ("Occupation Details" = "occupation details"::Employed) or ("Occupation Details" = "occupation details"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if ("Occupation Details" = "occupation details"::"Self-Employed") or ("Occupation Details" = "occupation details"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if ("Occupation Details" = "occupation details"::Others) or ("Occupation Details" = "occupation details"::Contracting) then begin
            OtherVisible := true;
        end;

        SetStyles();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Find(Which);
        CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInit()
    begin
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Customer Type" := "customer type"::Member;
        Status := Status::Active;
        "Customer Posting Group" := 'BOSA';
        "Registration Date" := Today;
        Advice := true;
        "Advice Type" := "advice type"::"New Member";
        if GeneralSetup.Get(0) then begin
            "Welfare Contribution" := GeneralSetup."Welfare Contribution";
            "Registration Fee" := GeneralSetup."Registration Fee";

        end;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if "Account Category" <> "account category"::Corporate then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if "Account Category" <> "account category"::Corporate then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;

        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if ("Occupation Details" = "occupation details"::Employed) or ("Occupation Details" = "occupation details"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if ("Occupation Details" = "occupation details"::"Self-Employed") or ("Occupation Details" = "occupation details"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if ("Occupation Details" = "occupation details"::Others) or ("Occupation Details" = "occupation details"::Contracting) then begin
            OtherVisible := true;
        end;


        if ("Assigned System ID" <> '') and ("Assigned System ID" <> UserId) then begin
            Error('You do not have permission to view account');
        end;
        CUeMgt.GetVisitFrequency(ObjCueControl.Activity::BOSA, "No.", Name);

    end;

    var
        CustomizedCalEntry: Record "Customized Calendar Entry";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        CustomizedCalendar: Record "Customized Calendar Change";
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        Vend: Record Vendor;
        Cust: Record Customer;
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        [InDataSet]
        lblIDVisible: Boolean;
        [InDataSet]
        lblDOBVisible: Boolean;
        [InDataSet]
        lblRegNoVisible: Boolean;
        [InDataSet]
        lblRegDateVisible: Boolean;
        [InDataSet]
        lblGenderVisible: Boolean;
        [InDataSet]
        txtGenderVisible: Boolean;
        [InDataSet]
        lblMaritalVisible: Boolean;
        [InDataSet]
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
        "WITHDRAWAL FEE": Decimal;
        "AMOUNTTO BE RECOVERED": Decimal;
        "Remaining Amount": Decimal;
        TotalInsuarance: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        FileMovementTracker: Record "File Movement Tracker";
        EntryNo: Integer;
        ApprovalsSetup: Record "Approvals Set Up";
        MovementTracker: Record "Movement Tracker";
        ApprovalUsers: Record "Approvals Users Set Up";
        "Change Log": Integer;
        openf: File;
        FMTRACK: Record "File Movement Tracker";
        CurrLocation: Code[30];
        "Number of days": Integer;
        Approvals: Record "Approvals Set Up";
        Description: Text[30];
        Section: Code[10];
        station: Code[10];
        MoveStatus: Record "File Movement Status";
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GuarantorAllocationAmount: Decimal;
        CummulativeGuaranteeAmount: Decimal;
        UserSetup: Record "User Setup";
        JointNameVisible: Boolean;
        SurestepFactory: Codeunit "SURESTEP Factory";
        ReasonforWithdrawal: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        SFactory: Codeunit "SURESTEP Factory";
        ObjMembershipApp: Record "Membership Applications";
        ObjCellGroups: Record "Member House Groups";
        CoveragePercentStyle: Text[50];
        EmployedVisible: Boolean;
        SelfEmployedVisible: Boolean;
        OtherVisible: Boolean;
        CUeMgt: Codeunit "Cue Management";
        ObjCueControl: Record "Control Cues";


    procedure ActivateFields()
    begin
    end;

    local procedure OnAfterGetCurrRecords()
    begin
        xRec := Rec;
        ActivateFields;
    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if "Member Risk Level" <> "member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if "Member Risk Level" = "member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;
}

