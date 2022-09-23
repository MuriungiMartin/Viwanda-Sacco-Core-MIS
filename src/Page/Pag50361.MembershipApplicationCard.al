#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50361 "Membership Application Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Editable = false;
                }
                field("Assigned No."; "Assigned No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Assigned Member No"; "Assigned Member No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Enabled = true;
                    Visible = true;

                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Category';
                    Editable = AccountCategoryEditable;
                    OptionCaption = 'Individual,Joint';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;
                        Joint3DetailsVisible := false;

                        if "Account Category" = "account category"::Corporate then begin
                            Joint2DetailsVisible := true;
                            Joint3DetailsVisible := true;
                        end;
                        if "Account Category" = "account category"::Individual then begin
                            Joint2DetailsVisible := false;
                            Joint3DetailsVisible := false;
                        end;
                    end;
                }
                group(Control40)
                {
                    Visible = Joint2DetailsVisible;
                    field("Joint Account Name"; "Joint Account Name")
                    {
                        ApplicationArea = Basic;
                        Enabled = FirstNameEditable;
                        Visible = Joint2DetailsVisible;
                    }
                    field("Signing Instructions"; "Signing Instructions")
                    {
                        ApplicationArea = Basic;
                        Enabled = FirstNameEditable;
                        Visible = Joint2DetailsVisible;
                    }
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FirstNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Name := "First Name";
                    end;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = MiddleNameEditable;

                    trigger OnValidate()
                    begin
                        Name := "First Name" + ' ' + "Middle Name";
                    end;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = LastNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Name := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Identification Document"; "Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = IdentificationDocTypeEditable;

                    trigger OnValidate()
                    begin
                        if "Identification Document" = "identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if "Identification Document" = "identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if "Identification Document" = "identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Position In The Sacco"; "Position In The Sacco")
                {

                }
                field("Member Paying Type"; "Member Paying Type")
                {

                }
                field("IPRS Details"; "IPRS Details")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("IPRS Error Description"; "IPRS Error Description")
                {
                    ApplicationArea = Basic;
                }
                field("Passport No."; "Passport No.")
                {
                    Editable = PassportEditable;
                }
                field("KRA PIN"; "KRA PIN")
                {
                    ApplicationArea = Basic;
                    Editable = KRAPinEditable;
                    ShowMandatory = true;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditable;
                    ShowMandatory = true;
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditable;
                    ShowMandatory = true;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileEditable;
                    ShowMandatory = true;
                }
                field("Secondary Mobile No"; "Secondary Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = SecondaryMobileEditable;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                }
                field("E-mail Indemnified"; "E-mail Indemnified")
                {
                    ApplicationArea = Basic;
                    Editable = EmailIndemnifiedEditable;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                    ShowMandatory = true;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
                    ShowMandatory = true;
                }
                field(Town; Town)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Country';
                    Editable = CountryEditable;
                }
                field(County; County)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                    Visible = false;
                }
                field(District; District)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Sub-Location"; "Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Member's Residence"; "Member's Residence")
                {
                    ApplicationArea = Basic;
                    Editable = MemberResidenceEditable;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                    Editable = PhysicalAddressEditable;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    ShowMandatory = true;
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
                }
                field("Application Category"; "Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = AppCategoryEditable;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Final Approver"; "Final Approver")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved By';
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
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Occupation Details")
            {
                Caption = 'Occupation Details';
                field("Employment Info"; "Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentInfoEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        EmployedVisible := false;
                        SelfEmployedVisible := false;
                        OtherVisible := false;

                        if ("Employment Info" = "employment info"::Employed) or ("Employment Info" = "employment info"::"Employed & Self Employed") then begin
                            EmployedVisible := true;
                        end;

                        if ("Employment Info" = "employment info"::"Self-Employed") or ("Employment Info" = "employment info"::"Employed & Self Employed") then begin
                            SelfEmployedVisible := true;
                        end;

                        if ("Employment Info" = "employment info"::Others) or ("Employment Info" = "employment info"::Contracting) then begin
                            OtherVisible := true;
                        end;

                        if "Identification Document" = "identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if "Identification Document" = "identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if "Identification Document" = "identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                group(Employed)
                {
                    Caption = 'Employment Details';
                    Visible = EmployedVisible;
                    field("Employment Status"; "Employment Status")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Employer Code"; "Employer Code")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployerCodeEditable;
                        ShowMandatory = true;
                    }
                    field("Employer Name"; "Employer Name")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployedEditable;
                    }
                    field("Employer Address"; "Employer Address")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployerAddressEditable;
                    }
                    field("Member Payment Type"; "Member Payment Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Terms of Employment"; "Terms of Employment")
                    {
                        ApplicationArea = Basic;
                        Editable = TermsofEmploymentEditable;
                        ShowMandatory = true;
                    }
                    field("Date of Employment"; "Date of Employment")
                    {
                        ApplicationArea = Basic;
                        Editable = EmploymentDateEditable;
                    }
                    field("Position Held"; "Position Held")
                    {
                        ApplicationArea = Basic;
                        Editable = PositionHeldEditable;
                    }
                }
                field("Expected Monthly Income"; "Expected Monthly Income")
                {
                    ApplicationArea = Basic;
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
                        Editable = NatureofBussEditable;
                    }
                    field(Industry; Industry)
                    {
                        ApplicationArea = Basic;
                        Editable = IndustryEditable;
                    }
                    field("Business Name"; "Business Name")
                    {
                        ApplicationArea = Basic;
                        Editable = BusinessNameEditable;
                    }
                    field("Physical Business Location"; "Physical Business Location")
                    {
                        ApplicationArea = Basic;
                        Editable = PhysicalBussLocationEditable;
                    }
                    field("Year of Commence"; "Year of Commence")
                    {
                        ApplicationArea = Basic;
                        Editable = YearOfCommenceEditable;
                    }
                }
                group(Other)
                {
                    Caption = 'Details';
                    Visible = OtherVisible;
                    field("Others Details"; "Others Details")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Occupation Details';
                        Editable = OthersEditable;
                    }
                }
            }
            group("Referee Details")
            {
                field("Referee Member No"; "Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = RefereeEditable;
                }
                field("Referee Name"; "Referee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Referee ID No"; "Referee ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Mobile Phone No"; "Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Member Risk Ratings")
            {
                group("Member Risk Rate")
                {
                    field("Individual Category"; "Individual Category")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Member Residency Status"; "Member Residency Status")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field(Entities; Entities)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Industry Type"; "Industry Type")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Length Of Relationship"; "Length Of Relationship")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("International Trade"; "International Trade")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                }
                group("Product Risk Rating")
                {
                    field("Electronic Payment"; "Electronic Payment")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Accounts Type Taken"; "Accounts Type Taken")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Cards Type Taken"; "Cards Type Taken")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Others(Channels)"; "Others(Channels)")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Member Risk Level"; "Member Risk Level")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Risk Level';
                        Editable = false;
                        //   Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; "Due Diligence Measure")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        //   Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }
                part(Control27; "Member Due Diligence Measure")
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
                field("First Name2"; "First Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2";
                    end;
                }
                field("Middle Name2"; "Middle Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2" + ' ' + "Middle Name2";
                    end;
                }
                field("Last Name2"; "Last Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2" + ' ' + "Middle Name2" + ' ' + "Last Name2";
                    end;
                }
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
                }
                field("Postal Code 2"; "Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 2"; "Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 3"; "Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth2"; "Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                }
                field("ID No.2"; "ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 2"; "Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender2; Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status2"; "Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code2"; "Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town2"; "Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code2"; "Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name2"; "Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal2)"; "E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("First Name3"; "First Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3";
                    end;
                }
                field("Middle Name 3"; "Middle Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3" + ' ' + "Middle Name 3";
                    end;
                }
                field("Last Name3"; "Last Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3" + ' ' + "Middle Name 3" + ' ' + "Last Name3";
                    end;
                }
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
                }
                field("Postal Code 3"; "Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 3"; "Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 4"; "Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth3"; "Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    ShowMandatory = true;
                }
                field("ID No.3"; "ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 3"; "Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender3; Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status3"; "Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code3"; "Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town3"; "Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code3"; "Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name3"; "Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal3)"; "E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                }

            }
        }
        area(factboxes)
        {
            part(Control35; "Member Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control36; "Member Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");

                    trigger OnAction()
                    begin
                        /*ObjProductsApp.RESET;
                        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
                        IF ObjProductsApp.FINDSET THEN BEGIN
                        ObjProductsApp.DELETEALL;
                        END;
                        
                        
                        AccoutTypes.RESET;
                        AccoutTypes.SETRANGE(AccoutTypes."Default Account",TRUE);
                         IF AccountTypes.FIND('-') THEN BEGIN
                            REPEAT
                              IF AccountTypes."Default Account"=TRUE THEN BEGIN
                              ObjProductsApp.INIT;
                              ObjProductsApp."Membership Applicaton No":="No.";
                              ObjProductsApp.Names:=Name;
                              ObjProductsApp.Product:=AccountTypes.Code;
                              ObjProductsApp."Product Name":=AccountTypes.Description;
                              ObjProductsApp."Product Source":=AccoutTypes."Activity Code";
                              ObjProductsApp.INSERT;
                              ObjProductsApp.VALIDATE(ObjProductsApp.Product);
                              ObjProductsApp.MODIFY;
                              END;
                            UNTIL AccountTypes.NEXT=0;
                          END;
                          */

                    end;
                }
                action("Next of Kin Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");

                    trigger OnAction()
                    begin
                        //===================================================================Signatory 1
                        if "Account Category" = "account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := "No.";
                            ObjMemberAppSignatories.Names := Name;
                            ObjMemberAppSignatories."ID No." := "ID No.";
                            ObjMemberAppSignatories."Date Of Birth" := "Date of Birth";
                            ObjMemberAppSignatories."Email Address" := "E-Mail (Personal)";
                            ObjMemberAppSignatories."Mobile No." := "Mobile Phone No";
                            ObjMemberAppSignatories.Insert;
                        end;

                        //===================================================================Signatory 2
                        if "Account Category" = "account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := "No.";
                            ObjMemberAppSignatories.Names := "Name 2";
                            ObjMemberAppSignatories."ID No." := "ID No.2";
                            ObjMemberAppSignatories."Date Of Birth" := "Date of Birth2";
                            ObjMemberAppSignatories."Email Address" := "E-Mail (Personal2)";
                            ObjMemberAppSignatories."Mobile No." := "Mobile No. 2";
                            ObjMemberAppSignatories.Insert;
                        end;

                        //===================================================================Signatory 3
                        if "Account Category" = "account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := "No.";
                            ObjMemberAppSignatories.Names := "Name 3";
                            ObjMemberAppSignatories."ID No." := "ID No.3";
                            ObjMemberAppSignatories."Date Of Birth" := "Date of Birth3";
                            ObjMemberAppSignatories."Email Address" := "E-Mail (Personal3)";
                            ObjMemberAppSignatories."Mobile No." := "Mobile No. 3";
                            ObjMemberAppSignatories.Insert;
                        end;
                    end;
                }
                action("Member Agent Details")
                {
                    ApplicationArea = Basic;
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Agent App  List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Member Sanction Information")
                {
                    ApplicationArea = Basic;
                    Image = ErrorLog;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership Application Saction";
                    RunPageLink = "Document No" = field("No.");
                }
                action("Member Risk Rating")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get Member Risk Rating';
                    Image = Reconcile;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Individual Member Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin
                        SFactory.FnGetMemberApplicationAMLRiskRating("No.");
                    end;
                }
                separator(Action6)
                {
                    Caption = '-';
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()

                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WFEvents: codeunit "Custom Workflow Events";
                    begin
                        FnValidatefields(rec);
                        if WorkflowManagement.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            WorkflowManagement.OnSendMembershipApplicationForApproval(Rec);


                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if "No." = 'MAP0001' then begin
                            Status := status::Open;
                        end;
                        // if Confirm('Are you sure you want to cancel this approval request', false) = true then
                        //     WorkflowManagement.OnCancelMembershipApplicationApprovalRequest(Rec);

                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.Setfilters(Database::"Membership Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = EnableCreateMember;

                    trigger OnAction()
                    var
                        VarAccounts: Text;
                        ObjAccountType: Record "Account Types-Saving Products";
                        SaccoNoSeries: Record "Sacco No. Series";
                    begin
                        if Status <> Status::Approved then
                            Error('The Membership Application must be approved before accounts are created');
                        TestField("Monthly Contribution");

                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                        if ObjProductsApp.FindSet = false then begin
                            Error('You must select products (account types) to be created for the member');
                        end;



                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                        ObjProductsApp.SetRange(ObjProductsApp.Product, 'MEMBERSHIP');
                        if ObjProductsApp.FindSet = false then begin
                            Error('You must select Membership product for a new Member for Member No to be assigned');
                        end;

                        if Confirm('Are you sure you want to create the selected accounts for the New Member?', false) = true then begin
                            ObjProductsApp.Reset;
                            ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                            ObjProductsApp.SetRange(ObjProductsApp."Product Source", ObjProductsApp."product source"::BOSA);
                            ObjProductsApp.SetRange(ObjProductsApp.Product, 'MEMBERSHIP');
                            if ObjProductsApp.FindSet then begin
                                //================================================================================================Back office Account


                                // ObjSaccosetup.Get();

                                // ObjMemberNoseries.Reset;
                                // ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                // ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                                // if ObjMemberNoseries.FindSet then begin
                                //     VarNewMembNo := ObjMemberNoseries."Account No";
                                // end;
                                // SaccoNoSeries.Get();
                                // VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Members Nos", Today, true);

                                //Create Member
                                //Message('the number is %1', VarNewMembNo);
                                CustomerTable."No." := "Assigned Member No";//Format(VarNewMembNo);
                                CustomerTable.Name := Name;
                                CustomerTable.Address := Address;
                                CustomerTable."Address 2" := "Address 2";
                                CustomerTable."Post Code" := "Postal Code";
                                CustomerTable.Town := Town;
                                CustomerTable.County := County;
                                CustomerTable.ISNormalMember := true;
                                CustomerTable."Member Paying Type" := "Member Paying Type";
                                CustomerTable."Position In The Sacco" := "Position In The Sacco";
                                CustomerTable.City := City;
                                CustomerTable."Country/Region Code" := "Country/Region Code";
                                CustomerTable."Phone No." := "Phone No.";
                                CustomerTable."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                CustomerTable."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                CustomerTable."Customer Posting Group" := "Customer Posting Group";
                                CustomerTable."Registration Date" := Today;
                                CustomerTable."Mobile Phone No" := "Mobile Phone No";
                                CustomerTable.Status := CustomerTable.Status::Active;
                                CustomerTable."Date of Birth" := "Date of Birth";
                                CustomerTable.Piccture := Picture;
                                CustomerTable.Signature := Signature;
                                CustomerTable."Station/Department" := "Station/Department";
                                CustomerTable."E-Mail" := "E-Mail (Personal)";
                                CustomerTable.Location := Location;
                                CustomerTable.Title := Title;
                                CustomerTable."Home Address" := "Home Address";
                                CustomerTable."Home Postal Code" := "Home Postal Code";
                                CustomerTable."Home Town" := "Home Town";
                                CustomerTable."Recruited By" := "Recruited By";
                                CustomerTable."Contact Person" := "Contact Person";
                                CustomerTable."ContactPerson Relation" := "ContactPerson Relation";
                                CustomerTable."ContactPerson Occupation" := "ContactPerson Occupation";
                                CustomerTable."Member Share Class" := "Member Share Class";
                                CustomerTable."Member's Residence" := "Member's Residence";
                                CustomerTable."Member House Group" := "Member House Group";
                                CustomerTable."Member House Group Name" := "Member House Group Name";
                                CustomerTable."Occupation Details" := "Employment Info";
                                CustomerTable."Employer Code" := "Employer Code";
                                CustomerTable."Employer Name" := "Employer Name";
                                CustomerTable."Employer Address" := "Employer Address";
                                CustomerTable."Terms Of Employment" := "Terms of Employment";
                                CustomerTable."Date of Employment" := "Date of Employment";
                                CustomerTable."Position Held" := "Position Held";
                                CustomerTable."Expected Monthly Income" := "Expected Monthly Income";
                                CustomerTable."Expected Monthly Income Amount" := "Expected Monthly Income Amount";
                                CustomerTable."Nature Of Business" := "Nature Of Business";
                                CustomerTable.Industry := Industry;
                                CustomerTable."Business Name" := "Business Name";
                                CustomerTable."Physical Business Location" := "Physical Business Location";
                                CustomerTable."Year of Commence" := "Year of Commence";
                                CustomerTable."Identification Document" := "Identification Document";
                                CustomerTable."Referee Member No" := "Referee Member No";
                                CustomerTable."Referee Name" := "Referee Name";
                                CustomerTable."Referee ID No" := "Referee ID No";
                                CustomerTable."Referee Mobile Phone No" := "Referee Mobile Phone No";
                                CustomerTable."Email Indemnified" := "E-mail Indemnified";
                                CustomerTable."Created By" := UserId;
                                CustomerTable."Member Needs House Group" := "Member Needs House Group";
                                CustomerTable."First Name" := "First Name";
                                CustomerTable."Middle Name" := "Middle Name";
                                CustomerTable."Last Name" := "Last Name";


                                //*****************************to Sort Joint
                                CustomerTable."Name 2" := "Name 2";
                                CustomerTable.Address3 := Address3;
                                CustomerTable."Postal Code 2" := "Postal Code 2";
                                CustomerTable."Home Postal Code2" := "Home Postal Code2";
                                CustomerTable."Home Town2" := "Home Town2";
                                CustomerTable."ID No.2" := "ID No.2";
                                CustomerTable."Passport 2" := "Passport 2";
                                CustomerTable.Gender2 := Gender2;
                                CustomerTable."Marital Status2" := "Marital Status2";
                                CustomerTable."E-Mail (Personal2)" := "E-Mail (Personal2)";
                                CustomerTable."Employer Code2" := "Employer Code2";
                                CustomerTable."Employer Name2" := "Employer Name2";
                                CustomerTable."Picture 2" := "Picture 2";
                                CustomerTable."Signature  2" := "Signature  2";


                                CustomerTable."Name 3" := "Name 3";
                                CustomerTable."Address3-Joint" := Address4;
                                CustomerTable."Postal Code 3" := "Postal Code 3";
                                CustomerTable."Home Postal Code3" := "Home Postal Code3";
                                CustomerTable."Mobile No. 4" := "Mobile No. 4";
                                CustomerTable."Home Town3" := "Home Town3";
                                CustomerTable."ID No.3" := "ID No.3";
                                CustomerTable."Passport 3" := "Passport 3";
                                CustomerTable.Gender3 := Gender3;
                                CustomerTable."Marital Status3" := "Marital Status3";
                                CustomerTable."E-Mail (Personal3)" := "E-Mail (Personal3)";
                                CustomerTable."Employer Code3" := "Employer Code3";
                                CustomerTable."Employer Name3" := "Employer Name3";
                                CustomerTable."Picture 3" := "Picture 3";
                                CustomerTable."Signature  3" := "Signature  3";
                                CustomerTable."Account Category" := "Account Category";
                                CustomerTable."Joint Account Name" := "Joint Account Name";
                                if "Account Category" = "account category"::Joint then
                                    CustomerTable.Name := "Joint Account Name";
                                //===================================================================================End Joint Account Details

                                //**
                                CustomerTable."Office Branch" := "Office Branch";
                                CustomerTable.Department := Department;
                                CustomerTable.Occupation := Occupation;
                                CustomerTable.Designation := Designation;
                                CustomerTable."Bank Code" := "Bank Code";
                                CustomerTable."Bank Branch Code" := "Bank Code";
                                CustomerTable."Bank Branch Name" := UpperCase("Bank Branch Name");
                                CustomerTable."Bank Name" := "Bank Name";
                                CustomerTable."Bank Account No." := "Bank Account No";
                                //**
                                CustomerTable."Sub-Location" := "Sub-Location";
                                CustomerTable.District := District;
                                CustomerTable."Payroll No" := "Payroll No";
                                CustomerTable."ID No." := "ID No.";
                                CustomerTable."Mobile Phone No" := "Mobile Phone No";
                                CustomerTable."Marital Status" := "Marital Status";
                                CustomerTable."Customer Type" := CustomerTable."customer type"::Member;
                                CustomerTable.Gender := Gender;

                                CustomerTable.Piccture := Picture;
                                CustomerTable.Signature := Signature;

                                CustomerTable."Monthly Contribution" := "Monthly Contribution";
                                CustomerTable."Contact Person" := "Contact Person";
                                CustomerTable."Contact Person Phone" := "Contact Person Phone";
                                CustomerTable."ContactPerson Relation" := "ContactPerson Relation";
                                CustomerTable."Recruited By" := "Recruited By";
                                CustomerTable."ContactPerson Occupation" := "ContactPerson Occupation";
                                CustomerTable."Village/Residence" := "Village/Residence";
                                CustomerTable.Pin := "KRA PIN";
                                CustomerTable."KYC Completed" := true;

                                //========================================================================Member Risk Rating
                                CustomerTable."Individual Category" := "Individual Category";
                                CustomerTable.Entities := Entities;
                                CustomerTable."Member Residency Status" := "Member Residency Status";
                                CustomerTable."Industry Type" := "Industry Type";
                                CustomerTable."Length Of Relationship" := "Length Of Relationship";
                                CustomerTable."International Trade" := "International Trade";
                                CustomerTable."Electronic Payment" := "Electronic Payment";
                                CustomerTable."Accounts Type Taken" := "Accounts Type Taken";
                                CustomerTable."Cards Type Taken" := "Cards Type Taken";

                                //======================================================Create Standing Order No.
                                if "Member Payment Type" = "member payment type"::"Standing Order" then begin
                                    if ObjNoSeries.Get then begin
                                        ObjNoSeries.TestField(ObjNoSeries."Standing Order Members Nos");
                                        VarStandingNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Standing Order Members Nos", 0D, true);
                                        if VarStandingNo <> '' then begin
                                            CustomerTable."Standing Order No" := VarStandingNo;
                                        end;
                                    end;
                                end;
                                CustomerTable.Insert(true);
                                //========================================================================End Member Risk Rating

                                ObjNextOfKinApp.Reset;
                                ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", "No.");
                                if ObjNextOfKinApp.Find('-') then begin
                                    repeat
                                        ObjNextOfKin.Init;
                                        ObjNextOfKin."Account No" := CustomerTable."No.";
                                        ObjNextOfKin.Name := ObjNextOfKinApp.Name;
                                        ObjNextOfKin.Relationship := ObjNextOfKinApp.Relationship;
                                        ObjNextOfKin.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                        ObjNextOfKin."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                        ObjNextOfKin.Address := ObjNextOfKinApp.Address;
                                        ObjNextOfKin.Telephone := ObjNextOfKinApp.Telephone;
                                        ObjNextOfKin.Email := ObjNextOfKinApp.Email;
                                        ObjNextOfKin."ID No." := ObjNextOfKinApp."ID No.";
                                        ObjNextOfKin."Member No" := ObjNextOfKinApp."Member No";
                                        ObjNextOfKin."%Allocation" := ObjNextOfKinApp."%Allocation";
                                        ObjNextOfKin.Description := ObjNextOfKinApp.Description;
                                        ObjNextOfKin."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                        ObjNextOfKin.Insert;
                                    until ObjNextOfKinApp.Next = 0;
                                end;

                                //==================================================================================Insert Member Agents
                                ObjMemberAppAgent.Reset;
                                ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", "No.");
                                if ObjMemberAppAgent.Find('-') then begin
                                    repeat

                                        if ObjNoSeries.Get then begin
                                            ObjNoSeries.TestField(ObjNoSeries."Agent Serial Nos");
                                            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Agent Serial Nos", 0D, true);
                                            if VarDocumentNo <> '' then begin
                                                ObjMemberAgent.Init;
                                                ObjMemberAgent."Document No" := VarDocumentNo;
                                                ObjMemberAgent."Account No" := CustomerTable."No.";
                                                ObjMemberAgent.Names := ObjMemberAppAgent.Names;
                                                ObjMemberAgent."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                                ObjMemberAgent."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                                ObjMemberAgent."ID No." := ObjMemberAppAgent."ID No.";
                                                ObjMemberAgent."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                                ObjMemberAgent."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                                ObjMemberAgent."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                                ObjMemberAgent."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                                ObjMemberAgent."Must Sign" := ObjMemberAppAgent."Must Sign";
                                                ObjMemberAgent."Must be Present" := ObjMemberAppAgent."Must be Present";
                                                ObjMemberAgent.Picture := ObjMemberAppAgent.Picture;
                                                ObjMemberAgent.Signature := ObjMemberAppAgent.Signature;
                                                ObjMemberAgent."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                                ObjMemberAgent.Insert;
                                            end;
                                        end;
                                    until ObjMemberAppAgent.Next = 0;
                                end;
                                //==================================================================================End Insert Member Agents

                                ObjMemberNoseries.Reset;
                                ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                                if ObjMemberNoseries.FindSet then begin
                                    ObjMemberNoseries."Account No" := IncStr(ObjMemberNoseries."Account No");
                                    ObjMemberNoseries.Modify;
                                end;
                                VarBOSAACC := CustomerTable."No.";
                            end;
                        end;

                        //==================================================================================================End Membership Registration

                        //==========================================s========================================================Member Accounts Accounts
                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1', 'MEMBERSHIP');
                        //ObjProductsApp.SETFILTER(ObjProductsApp.Product,'<>%1','');
                        if ObjProductsApp.FindSet then begin
                            repeat

                                ObjMemberNoseries.Reset;
                                ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                                if ObjMemberNoseries.FindSet then begin
                                    VarAcctNo := ObjMemberNoseries."Account No";
                                end;

                                if "Account Category" = "account category"::Individual then begin
                                    ObjAccounts.Reset;
                                    ObjAccounts.SetRange(ObjAccounts."ID No.", "ID No.");
                                    ObjAccounts.SetRange(ObjAccounts."Account Type", ObjProductsApp.Product);
                                    ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1&<>%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                                    if ObjAccounts.FindSet then begin
                                        Error('The Member has an existing %1', ObjAccounts."Account Type");
                                    end;
                                end;

                                //===================================================================Create Account
                                ObjAccounts.Init;
                                ObjAccounts."No." := VarAcctNo;
                                ObjAccounts."Date of Birth" := "Date of Birth";
                                ObjAccounts.Name := Name;
                                ObjAccounts."Creditor Type" := ObjAccounts."creditor type"::"FOSA Account";
                                ObjAccounts."Personal No." := "Payroll No";
                                ObjAccounts."ID No." := "ID No.";
                                ObjAccounts."Mobile Phone No" := "Mobile Phone No";
                                ObjAccounts."Phone No." := "Mobile Phone No";
                                ObjAccounts."Registration Date" := "Registration Date";
                                ObjAccounts."Post Code" := "Postal Code";
                                ObjAccounts.County := City;
                                ObjAccounts."BOSA Account No" := CustomerTable."No.";
                                ObjAccounts."Passport No." := "Passport No.";
                                ObjAccounts."Employer Code" := "Employer Code";
                                ObjAccounts.Status := ObjAccounts.Status::Deceased;
                                ObjAccounts."Account Type" := ObjProductsApp.Product;
                                ObjAccounts."Date of Birth" := "Date of Birth";
                                ObjAccounts."Global Dimension 1 Code" := Format(ObjProductsApp."Product Source");
                                ObjAccounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                ObjAccounts.Address := Address;
                                if "Account Category" = "account category"::Joint then begin
                                    ObjAccounts."Account Category" := ObjAccounts."account category"::Corporate
                                end else
                                    ObjAccounts."Account Category" := "Account Category";
                                ObjAccounts."Address 2" := "Address 2";
                                ObjAccounts."Phone No." := "Mobile Phone No";
                                ObjAccounts."Registration Date" := Today;
                                ObjAccounts.Status := ObjAccounts.Status::Active;
                                ObjAccounts.Section := Section;
                                ObjAccounts."Home Address" := "Home Address";
                                ObjAccounts.District := District;
                                ObjAccounts.Location := Location;
                                ObjAccounts."Sub-Location" := "Sub-Location";
                                ObjAccounts."Registration Date" := Today;
                                ObjAccounts."Monthly Contribution" := "Monthly Contribution";
                                ObjAccounts."E-Mail" := "E-Mail (Personal)";
                                ObjAccounts."Group/Corporate Trade" := "Group/Corporate Trade";
                                ObjAccounts."Name of the Group/Corporate" := "Name of the Group/Corporate";
                                ObjAccounts."Signing Instructions" := "Signing Instructions";
                                ObjAccounts."Certificate No" := "Certificate No";
                                ObjAccounts."Registration Date" := "Registration Date";
                                ObjAccounts."Created By" := UserId;

                                //=============================================================Joint Account Details
                                ObjAccounts."Name 2" := "Name 2";
                                ObjAccounts."Address3-Joint" := Address3;
                                ObjAccounts."Postal Code 2" := "Postal Code 2";
                                ObjAccounts."Home Postal Code2" := "Home Postal Code2";
                                ObjAccounts."Home Town2" := "Home Town2";
                                ObjAccounts."ID No.2" := "ID No.2";
                                ObjAccounts."Passport 2" := "Passport 2";
                                ObjAccounts.Gender2 := Gender2;
                                ObjAccounts."Marital Status2" := "Marital Status2";
                                ObjAccounts."E-Mail (Personal2)" := "E-Mail (Personal2)";
                                ObjAccounts."Employer Code2" := "Employer Code2";
                                ObjAccounts."Employer Name2" := "Employer Name2";
                                ObjAccounts."Picture 2" := "Picture 2";
                                ObjAccounts."Signature  2" := "Signature  2";
                                ObjAccounts."Member's Residence" := "Member's Residence";
                                ObjAccounts."Joint Account Name" := "Joint Account Name";

                                ObjAccounts."Name 3" := "Name 3";
                                ObjAccounts."Address3-Joint" := Address4;
                                ObjAccounts."Postal Code 3" := "Postal Code 3";
                                ObjAccounts."Home Postal Code3" := "Home Postal Code3";
                                ObjAccounts."Home Town3" := "Home Town3";
                                ObjAccounts."ID No.3" := "ID No.3";
                                ObjAccounts."Passport 3" := "Passport 3";
                                ObjAccounts.Gender3 := Gender3;
                                ObjAccounts."Marital Status3" := "Marital Status3";
                                ObjAccounts."E-Mail (Personal3)" := "E-Mail (Personal3)";
                                ObjAccounts."Employer Code3" := "Employer Code3";
                                ObjAccounts."Employer Name3" := "Employer Name3";
                                ObjAccounts."Picture 3" := "Picture 3";
                                ObjAccounts."Signature  3" := "Signature  3";
                                ObjAccounts."Joint Account Name" := "Joint Account Name";


                                //=============================================================End Joint Account Details
                                ObjAccounts.Insert;


                                ObjAccounts.Reset;
                                if ObjAccounts.Get(VarAcctNo) then begin
                                    ObjAccounts.Validate(ObjAccounts.Name);
                                    ObjAccounts.Validate(ObjAccounts."Account Type");
                                    ObjAccounts.Modify;


                                    ObjMemberNoseries.Reset;
                                    ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                    ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                                    if ObjMemberNoseries.FindSet then begin
                                        ObjMemberNoseries."Account No" := IncStr(ObjMemberNoseries."Account No");
                                        ObjMemberNoseries.Modify;
                                    end;



                                    //Update Member with FOSA Account
                                    if CustomerTable.Get(VarBOSAACC) then begin
                                        CustomerTable."FOSA Account No." := VarAcctNo;
                                        CustomerTable.Modify;
                                    end;
                                end;

                                ObjNextOfKinApp.Reset;
                                ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", "No.");
                                if ObjNextOfKinApp.Find('-') then begin
                                    repeat
                                        ObjNextofKinFOSA.Init;
                                        ObjNextofKinFOSA."Account No" := VarAcctNo;
                                        ObjNextofKinFOSA.Name := ObjNextOfKinApp.Name;
                                        ObjNextofKinFOSA.Relationship := ObjNextOfKinApp.Relationship;
                                        ObjNextofKinFOSA.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                        ObjNextofKinFOSA."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                        ObjNextofKinFOSA.Address := ObjNextOfKinApp.Address;
                                        ObjNextofKinFOSA.Telephone := ObjNextOfKinApp.Telephone;
                                        ObjNextofKinFOSA.Email := ObjNextOfKinApp.Email;
                                        ObjNextofKinFOSA."ID No." := ObjNextOfKinApp."ID No.";
                                        ObjNextofKinFOSA."Member No" := ObjNextOfKinApp."Member No";
                                        ObjNextofKinFOSA."%Allocation" := ObjNextOfKinApp."%Allocation";
                                        ObjNextofKinFOSA."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                        ObjNextofKinFOSA.Insert;
                                    until ObjNextOfKinApp.Next = 0;
                                end;

                                //==================================================================================================Insert Account Agents
                                ObjMemberAppAgent.Reset;
                                ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", "No.");
                                if ObjMemberAppAgent.Find('-') then begin
                                    repeat
                                        if ObjNoSeries.Get then begin
                                            ObjNoSeries.TestField(ObjNoSeries."Agent Serial Nos");
                                            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Agent Serial Nos", 0D, true);
                                            if VarDocumentNo <> '' then begin
                                                ObjAccountAgents.Init;
                                                ObjAccountAgents."Document No" := VarDocumentNo;
                                                ObjAccountAgents."Account No" := VarAcctNo;
                                                ObjAccountAgents.Names := ObjMemberAppAgent.Names;
                                                ObjAccountAgents."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                                ObjAccountAgents."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                                ObjAccountAgents."ID No." := ObjMemberAppAgent."ID No.";
                                                ObjAccountAgents."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                                ObjAccountAgents."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                                ObjAccountAgents."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                                ObjAccountAgents."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                                ObjAccountAgents."Must Sign" := ObjMemberAppAgent."Must Sign";
                                                ObjAccountAgents."Must be Present" := ObjMemberAppAgent."Must be Present";
                                                ObjAccountAgents."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                                ObjAccountAgents.Insert;
                                            end;
                                        end;
                                    until ObjMemberAppAgent.Next = 0;
                                end;
                                //==================================================================================================End Insert Account Agents

                                ObjAccountSignApp.Reset;
                                ObjAccountSignApp.SetRange(ObjAccountSignApp."Account No", "No.");
                                if ObjAccountSignApp.Find('-') then begin
                                    repeat
                                        if ObjNoSeries.Get then begin
                                            ObjNoSeries.TestField(ObjNoSeries."Signatories Document No");
                                            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Signatories Document No", 0D, true);
                                            if VarDocumentNo <> '' then begin
                                                ObjAccountSign.Init;
                                                ObjAccountSign."Document No" := VarDocumentNo;
                                                ObjAccountSign."Account No" := VarAcctNo;
                                                ObjAccountSign.Names := ObjAccountSignApp.Names;
                                                ObjAccountSign."Date Of Birth" := ObjAccountSignApp."Date Of Birth";
                                                ObjAccountSign."Staff/Payroll" := ObjAccountSignApp."Staff/Payroll";
                                                ObjAccountSign."ID No." := ObjAccountSignApp."ID No.";
                                                ObjAccountSign.Signatory := ObjAccountSignApp.Signatory;
                                                ObjAccountSign."Must Sign" := ObjAccountSignApp."Must Sign";
                                                ObjAccountSign."Must be Present" := ObjAccountSignApp."Must be Present";
                                                ObjAccountSign.Picture := ObjAccountSignApp.Picture;
                                                ObjAccountSign.Signature := ObjAccountSignApp.Signature;
                                                ObjAccountSign."Expiry Date" := ObjAccountSignApp."Expiry Date";
                                                ObjAccountSign.Insert;
                                            end;
                                        end;
                                    until ObjAccountSignApp.Next = 0;
                                end;





                                //END;
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                GenJournalLine.DeleteAll;

                                ObjGenSetUp.Get();

                                //Charge Registration Fee
                                if ObjGenSetUp."Charge FOSA Registration Fee" = true then begin

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'REGFee';
                                    GenJournalLine."Document No." := "No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := VarAcctNo;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."External Document No." := 'REGFEE/' + Format("Payroll No");
                                    GenJournalLine.Description := 'Registration Fee';
                                    GenJournalLine.Amount := ObjGenSetUp."BOSA Registration Fee Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := ObjGenSetUp."FOSA Registration Fee Account";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;



                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                    end;
                                end;
                                Message('You have successfully created a %1 Product, A/C No=%2', ObjProductsApp.Product, VarAcctNo);

                            //End Charge Registration Fee
                            until ObjProductsApp.Next = 0;
                        end;
                        Message('You have successfully Registered a New Sacco Member. Membership No=%1.The Member will be notifed via SMS and/or Email.', CustomerTable."No.");

                        //=================================================================================================================End Member Accounts


                        if "Member Payment Type" = "member payment type"::"Standing Order" then
                            Message('Member Standing order No is %1', VarStandingNo);

                        ObjGenSetUp.Get();

                        //=====================================================================================================Send SMS
                        if ObjGenSetUp."Send Membership Reg SMS" = true then begin
                            VarAccounts := '';
                            ObjAccounts.Reset;
                            ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
                            if ObjAccounts.FindSet then begin
                                repeat
                                    if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                                        VarAccounts := VarAccounts + Format(ObjAccounts."No.") + ' - ' + Format(ObjAccountType."Product Short Name") + '; ';
                                    end;
                                until ObjAccounts.Next = 0;
                            end;
                            SFactory.FnSendSMS('MEMBERAPP', 'You Membership Registration has been completed. Your Member No is ' + VarBOSAACC + ' and your Accounts are: ' + VarAccounts,
                            VarBOSAACC, "Mobile Phone No");
                        end;

                        //======================================================================================================Send Email
                        if ObjGenSetUp."Send Membership Reg Email" = true then begin
                            FnSendRegistrationEmail("No.", "E-Mail (Personal)", "ID No.", VarBOSAACC);
                        end;
                        Created := true;

                        CalcFields("Assigned No.");
                        //FnRuninsertBOSAAccountNos("Assigned No.");//========================================================================Update Membership Account with BOSA Account Nos
                    end;
                }
                action("Update KYC Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Update KYC Details';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = EnableUpdateKYC;

                    trigger OnAction()
                    var
                        VarAccounts: Text;
                        ObjAccountType: Record "Account Types-Saving Products";
                    begin
                        if Status <> Status::Approved then
                            Error('The Membership Application must be approved before KYC Details are updated');

                        //FnRunEnsureDueDiligenceMeasureChecked;
                        CustomerTable.Reset;
                        CustomerTable.SetRange(CustomerTable."ID No.", "ID No.");
                        if CustomerTable.FindSet then begin
                            CustomerTable.Address := Address;
                            CustomerTable."Address 2" := "Address 2";
                            CustomerTable."Post Code" := "Postal Code";
                            CustomerTable.Town := Town;
                            CustomerTable.County := County;
                            CustomerTable.City := City;
                            CustomerTable."Country/Region Code" := "Country/Region Code";
                            CustomerTable."Phone No." := "Phone No.";
                            CustomerTable."Date of Birth" := "Date of Birth";
                            CustomerTable.Piccture := Picture;
                            CustomerTable.Signature := Signature;
                            CustomerTable."E-Mail" := "E-Mail (Personal)";
                            CustomerTable.Location := Location;
                            CustomerTable.Title := Title;
                            CustomerTable."Home Address" := "Home Address";
                            CustomerTable."Home Postal Code" := "Home Postal Code";
                            CustomerTable."Home Town" := "Home Town";
                            CustomerTable."Recruited By" := "Recruited By";
                            CustomerTable."Contact Person" := "Contact Person";
                            CustomerTable."ContactPerson Relation" := "ContactPerson Relation";
                            CustomerTable."ContactPerson Occupation" := "ContactPerson Occupation";
                            CustomerTable."Member Share Class" := "Member Share Class";
                            CustomerTable."Member's Residence" := "Member's Residence";
                            CustomerTable."Member House Group" := "Member House Group";
                            CustomerTable."Member House Group Name" := "Member House Group Name";
                            CustomerTable."Occupation Details" := "Employment Info";
                            CustomerTable."Employer Code" := "Employer Code";
                            CustomerTable."Employer Name" := "Employer Name";
                            CustomerTable."Employer Address" := "Employer Address";
                            CustomerTable."Terms Of Employment" := "Terms of Employment";
                            CustomerTable."Date of Employment" := "Date of Employment";
                            CustomerTable."Position Held" := "Position Held";
                            CustomerTable."Expected Monthly Income" := "Expected Monthly Income";
                            CustomerTable."Expected Monthly Income Amount" := "Expected Monthly Income Amount";
                            CustomerTable."Nature Of Business" := "Nature Of Business";
                            CustomerTable.Industry := Industry;
                            CustomerTable."Business Name" := "Business Name";
                            CustomerTable."Physical Business Location" := "Physical Business Location";
                            CustomerTable."Year of Commence" := "Year of Commence";
                            CustomerTable."Identification Document" := "Identification Document";
                            CustomerTable."Referee Member No" := "Referee Member No";
                            CustomerTable."Referee Name" := "Referee Name";
                            CustomerTable."Referee ID No" := "Referee ID No";
                            CustomerTable."Referee Mobile Phone No" := "Referee Mobile Phone No";
                            CustomerTable."Email Indemnified" := "E-mail Indemnified";
                            CustomerTable."Member Needs House Group" := "Member Needs House Group";


                            //*****************************to Sort Joint
                            CustomerTable."Name 2" := "Name 2";
                            CustomerTable.Address3 := Address3;
                            CustomerTable."Postal Code 2" := "Postal Code 2";
                            CustomerTable."Home Postal Code2" := "Home Postal Code2";
                            CustomerTable."Home Town2" := "Home Town2";
                            CustomerTable."ID No.2" := "ID No.2";
                            CustomerTable."Passport 2" := "Passport 2";
                            CustomerTable.Gender2 := Gender2;
                            CustomerTable."Marital Status2" := "Marital Status2";
                            CustomerTable."E-Mail (Personal2)" := "E-Mail (Personal2)";
                            CustomerTable."Employer Code2" := "Employer Code2";
                            CustomerTable."Employer Name2" := "Employer Name2";
                            CustomerTable."Picture 2" := "Picture 2";
                            CustomerTable."Signature  2" := "Signature  2";


                            CustomerTable."Name 3" := "Name 3";
                            CustomerTable."Address3-Joint" := Address4;
                            CustomerTable."Postal Code 3" := "Postal Code 3";
                            CustomerTable."Home Postal Code3" := "Home Postal Code3";
                            CustomerTable."Mobile No. 4" := "Mobile No. 4";
                            CustomerTable."Home Town3" := "Home Town3";
                            CustomerTable."ID No.3" := "ID No.3";
                            CustomerTable."Passport 3" := "Passport 3";
                            CustomerTable.Gender3 := Gender3;
                            CustomerTable."Marital Status3" := "Marital Status3";
                            CustomerTable."E-Mail (Personal3)" := "E-Mail (Personal3)";
                            CustomerTable."Employer Code3" := "Employer Code3";
                            CustomerTable."Employer Name3" := "Employer Name3";
                            CustomerTable."Picture 3" := "Picture 3";
                            CustomerTable."Signature  3" := "Signature  3";
                            CustomerTable."Account Category" := "Account Category";
                            CustomerTable."Joint Account Name" := "Joint Account Name";
                            if "Account Category" = "account category"::Joint then
                                CustomerTable.Name := "Joint Account Name";
                            //===================================================================================End Joint Account Details

                            //**
                            CustomerTable."Office Branch" := "Office Branch";
                            CustomerTable.Department := Department;
                            CustomerTable.Occupation := Occupation;
                            CustomerTable.Designation := Designation;
                            CustomerTable."Bank Code" := "Bank Code";
                            CustomerTable."Bank Branch Code" := "Bank Name";
                            CustomerTable."Bank Account No." := "Bank Account No";
                            //**
                            CustomerTable."Sub-Location" := "Sub-Location";
                            CustomerTable.District := District;
                            CustomerTable."Payroll No" := "Payroll No";
                            CustomerTable."ID No." := "ID No.";
                            CustomerTable."Mobile Phone No" := "Mobile Phone No";
                            CustomerTable."Marital Status" := "Marital Status";
                            CustomerTable."Customer Type" := CustomerTable."customer type"::Member;
                            CustomerTable.Gender := Gender;

                            CustomerTable.Piccture := Picture;
                            CustomerTable.Signature := Signature;

                            CustomerTable."Monthly Contribution" := "Monthly Contribution";
                            CustomerTable."Contact Person" := "Contact Person";
                            CustomerTable."Contact Person Phone" := "Contact Person Phone";
                            CustomerTable."ContactPerson Relation" := "ContactPerson Relation";
                            CustomerTable."Recruited By" := "Recruited By";
                            CustomerTable."ContactPerson Occupation" := "ContactPerson Occupation";
                            CustomerTable."Village/Residence" := "Village/Residence";
                            CustomerTable.Pin := "KRA PIN";
                            CustomerTable."KYC Completed" := true;

                            //========================================================================Member Risk Rating
                            CustomerTable."Individual Category" := "Individual Category";
                            CustomerTable.Entities := Entities;
                            CustomerTable."Member Residency Status" := "Member Residency Status";
                            CustomerTable."Industry Type" := "Industry Type";
                            CustomerTable."Length Of Relationship" := "Length Of Relationship";
                            CustomerTable."International Trade" := "International Trade";
                            CustomerTable."Electronic Payment" := "Electronic Payment";
                            CustomerTable."Accounts Type Taken" := "Accounts Type Taken";
                            CustomerTable."Cards Type Taken" := "Cards Type Taken";
                            CustomerTable.Modify;
                            //========================================================================End Member Risk Rating


                        end;
                        Message('You have successfully Updated the KYC Details for Member No=%1.The Member will be notifed via SMS and/or Email.', CustomerTable."No.");

                        ObjGenSetUp.Get();

                        //=====================================================================================================Send SMS
                        if ObjGenSetUp."Send Membership Reg SMS" = true then begin
                            SFactory.FnSendSMS('MEMBERAPP', 'Dear ' + "First Name" + ', you Membership KYC Details have been completed. You can now transact on your Accounts without any limits.',
                            CustomerTable."No.", "Mobile Phone No");
                        end;

                        //======================================================================================================Send Email
                        if ObjGenSetUp."Send Membership Reg Email" = true then begin
                            FnSendKYCUpdateEmail("No.", "E-Mail (Personal)", "ID No.", CustomerTable."No.");
                        end;
                        "KYC Completed" := true;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    // WorkflowManagement: Codeunit "Workflow Management";
    // WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        UpdateControls();
        EnableCreateMember := false;
        EnableUpdateKYC := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;

        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Status::Approved) then
            EnableCreateMember := true;

        if Created = true then
            EnableCreateMember := false;

        if (Created = true) and ("KYC Completed" = false) and ("Online Application" = true) then
            EnableUpdateKYC := true;

        ObjGenSetUp.Get;
        "Monthly Contribution" := ObjGenSetUp."Min. Contribution";
    end;

    trigger OnAfterGetRecord()
    begin

        StyleText := 'UnFavorable';



        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if ("Employment Info" = "employment info"::Employed) or ("Employment Info" = "employment info"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if ("Employment Info" = "employment info"::"Self-Employed") or ("Employment Info" = "employment info"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if ("Employment Info" = "employment info"::Others) or ("Employment Info" = "employment info"::Contracting) then begin
            OtherVisible := true;
        end;

        if "Identification Document" = "identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if "Identification Document" = "identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if "Identification Document" = "identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;

        SetStyles();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Responsibility Centre" := ObjUserMgt.GetSalesFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        ObjGenSetUp.Get();
        "Monthly Contribution" := ObjGenSetUp."Monthly Share Contributions";
        "Customer Posting Group" := ObjGenSetUp."Default Customer Posting Group";
        // "Global Dimension 1 Code" := 'BOSA';
        // "Global Dimension 2 Code" := 'NAIROBI';
        //"Self Recruited":=TRUE;





        /*IF "Account Category"<>"Account Category"::Joint THEN BEGIN
        Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        END ELSE
        Joint2DetailsVisible:=TRUE;
        Joint3DetailsVisible:=TRUE;*/

    end;

    trigger OnOpenPage()
    begin

        if ObjUserMgt.GetSalesFilter <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Centre", ObjUserMgt.GetSalesFilter);
            FilterGroup(0);
        end;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if "Account Category" = "account category"::Corporate then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;
        if "Account Category" = "account category"::Individual then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end;

        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if ("Employment Info" = "employment info"::Employed) or ("Employment Info" = "employment info"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if ("Employment Info" = "employment info"::"Self-Employed") or ("Employment Info" = "employment info"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if ("Employment Info" = "employment info"::Others) or ("Employment Info" = "employment info"::Contracting) then begin
            OtherVisible := true;
        end;




        if "Identification Document" = "identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if "Identification Document" = "identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if "Identification Document" = "identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        ObjCust: Record Customer;
        ObjAccounts: Record Vendor;
        VarAcctNo: Code[20];
        ObjNextOfKinApp: Record "Member App Nominee";
        ObjAccountSign: Record "FOSA Account Sign. Details";
        ObjAccountSignApp: Record "Member App Signatories";
        ObjAcc: Record Vendor;
        UsersID: Record User;
        ObjNok: Record "Member App Nominee";
        ObjNOKBOSA: Record "Members Next of Kin";
        VarBOSAACC: Code[20];
        ObjNextOfKin: Record "Members Next of Kin";
        VarPictureExists: Boolean;
        text001: label 'Status must be open';
        ObjUserMgt: Codeunit "User Setup Management";
        ObjNotificationE: Codeunit Mail;
        VarMailBody: Text[250];
        VarccEmail: Text[1000];
        VartoEmail: Text[1000];
        ObjGenSetUp: Record "Sacco General Set-Up";
        VarClearingAcctNo: Code[20];
        VarAdvrAcctNo: Code[20];
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarDivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        EmployerNameEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        ProductEditable: Boolean;
        SecondaryMobileEditable: Boolean;
        AccountCategoryEditable: Boolean;
        OfficeTelephoneEditable: Boolean;
        OfficeExtensionEditable: Boolean;
        MemberParishEditable: Boolean;
        KnowDimkesEditable: Boolean;
        CountyEditable: Boolean;
        DistrictEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        EmploymentInfoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        VarNewMembNo: Code[30];
        ObjSaccosetup: Record "Sacco No. Series";
        ObjNOkApp: Record "Member App Nominee";
        TitleEditable: Boolean;
        PostalCodeEditable: Boolean;
        HomeAddressPostalCodeEditable: Boolean;
        HomeTownEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        CopyOFIDEditable: Boolean;
        CopyofPassportEditable: Boolean;
        SpecimenEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        PayslipEditable: Boolean;
        RegistrationFeeEditable: Boolean;
        CopyofKRAPinEditable: Boolean;
        membertypeEditable: Boolean;
        FistnameEditable: Boolean;
        dateofbirth2: Boolean;
        registrationeditable: Boolean;
        EstablishdateEditable: Boolean;
        RegistrationofficeEditable: Boolean;
        Signature2Editable: Boolean;
        Picture2Editable: Boolean;
        MembApp: Record "Membership Applications";
        title2Editable: Boolean;
        mobile3editable: Boolean;
        emailaddresEditable: Boolean;
        gender2editable: Boolean;
        postal2Editable: Boolean;
        town2Editable: Boolean;
        passpoetEditable: Boolean;
        maritalstatus2Editable: Boolean;
        payrollno2editable: Boolean;
        Employercode2Editable: Boolean;
        address3Editable: Boolean;
        DateOfAppointmentEDitable: Boolean;
        TermsofServiceEditable: Boolean;
        HomePostalCode2Editable: Boolean;
        Employername2Editable: Boolean;
        ageEditable: Boolean;
        CopyofconstitutionEditable: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        RecruitedByEditable: Boolean;
        RecruiterNameEditable: Boolean;
        RecruiterRelationShipEditable: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        NomineeEditable: Boolean;
        TownEditable: Boolean;
        CountryEditable: Boolean;
        MobileEditable: Boolean;
        PassportEditable: Boolean;
        RejoiningDateEditable: Boolean;
        PrevousRegDateEditable: Boolean;
        AppCategoryEditable: Boolean;
        RegistrationDateEditable: Boolean;
        ObjDataSheet: Record "Data Sheet Main";
        ObjSMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjUsersRec: Record User;
        Joint3DetailsVisible: Boolean;
        CompInfo: Record "Company Information";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FirstNameEditable: Boolean;
        MiddleNameEditable: Boolean;
        LastNameEditable: Boolean;
        PayrollNoEditable: Boolean;
        MemberResidenceEditable: Boolean;
        ShareClassEditable: Boolean;
        KRAPinEditable: Boolean;
        ObjViewLog: Record "View Log Entry";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        ObjAccountAppAgent: Record "Account Agents App Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjMemberAppAgent: Record "Member Agents App Details";
        ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        RefereeEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record Customer;
        ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        StyleText: Text[20];
        CoveragePercentStyle: Text;
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarAccountTypes: Text[1000];
        VarAccountDescription: Text[1000];
        ObjAccountType: Record "Account Types-Saving Products";
        VarMemberName: Text[100];
        SurestepFactory: Codeunit "SURESTEP Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;
        VarTextExtension: Text;
        VarTextExtensionII: Text;
        VarEnableNeedHouse: Boolean;
        EmployedVisible: Boolean;
        SelfEmployedVisible: Boolean;
        OtherVisible: Boolean;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarProductCount: Integer;
        ObjMemberAppSignatories: Record "Member App Signatories";
        EnableUpdateKYC: Boolean;
        VarStandingNo: Code[20];
        WorkflowManagement: Codeunit WorkflowIntegration;
        CustomerTable: Record Customer;


    procedure UpdateControls()
    begin

        if (Status = Status::Approved) or (("Online Application" = true) and ("KYC Completed" = true)) then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;

        if Status = Status::"Pending Approval" then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if (Status = Status::Open) or (("Online Application" = true) and ("KYC Completed" = false)) then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := true;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := true;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            title2Editable := true;
            emailaddresEditable := true;
            gender2editable := true;
            HomePostalCode2Editable := true;
            town2Editable := true;
            passpoetEditable := true;
            maritalstatus2Editable := true;
            payrollno2editable := true;
            Employercode2Editable := true;
            address3Editable := true;
            Employername2Editable := true;
            ageEditable := true;
            mobile3editable := true;
            CopyofconstitutionEditable := true;
            NomineeEditable := true;
            TownEditable := true;
            CountryEditable := true;
            MobileEditable := true;
            PassportEditable := true;
            RejoiningDateEditable := true;
            PrevousRegDateEditable := true;
            AppCategoryEditable := true;
            RegistrationDateEditable := true;
            TermsofServiceEditable := true;
            ProductEditable := true;
            SecondaryMobileEditable := true;
            AccountCategoryEditable := true;
            OfficeTelephoneEditable := true;
            OfficeExtensionEditable := true;
            CountyEditable := true;
            DistrictEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            EmploymentInfoEditable := true;
            MemberParishEditable := true;
            KnowDimkesEditable := true;
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            FirstNameEditable := true;
            MiddleNameEditable := true;
            LastNameEditable := true;
            PayrollNoEditable := true;
            MemberResidenceEditable := true;
            ShareClassEditable := true;
            KRAPinEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            NatureofBussEditable := true;
            IndustryEditable := true;
            BusinessNameEditable := true;
            PhysicalBussLocationEditable := true;
            YearOfCommenceEditable := true;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            IdentificationDocTypeEditable := true;
            PhysicalAddressEditable := true;
            RefereeEditable := true;
            MonthlyIncomeEditable := true;
        end
    end;

    local procedure SelfRecruitedControl()
    begin
        /*
            IF "Self Recruited"=TRUE THEN BEGIN
             RecruitedByEditable:=FALSE;
             RecruiterNameEditable:=FALSE;
             RecruiterRelationShipEditable:=FALSE;
             END ELSE
            IF "Self Recruited"<>TRUE THEN BEGIN
             RecruitedByEditable:=TRUE;
             RecruiterNameEditable:=TRUE;
             RecruiterRelationShipEditable:=TRUE;
             END;
             */

    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := "No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBAPP';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := "Mobile Phone No";
        if "Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := "No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBREG';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + VarBOSAACC + ' Name ' + Name + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := "Mobile Phone No";
        if "Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;

    local procedure UpdateViewLogEntries()
    begin
        ObjViewLog.Init;
        ObjViewLog."Entry No." := ObjViewLog."Entry No." + 1;
        ObjViewLog."User ID" := UserId;
        ObjViewLog."Table No." := 51516364;
        ObjViewLog."Table Caption" := 'Members Register';
        ObjViewLog.Date := Today;
        ObjViewLog.Time := Time;
    end;

    local procedure FnCheckfieldrestriction()
    begin
        if ("Account Category" = "account category"::Individual) then begin
            //CALCFIELDS(Picture,Signature);
            TestField(Name);
            TestField("ID No.");
            TestField("Mobile Phone No");
            TestField("Country/Region Code");
            TestField("Monthly Contribution");
            TestField(Gender);
            TestField("Employment Info");
            TestField("KRA PIN");
            TestField("Customer Posting Group");
            if "Account Category" = "account category"::Individual then begin
                //TESTFIELD(Picture);
                //TESTFIELD(Signature);
            end;
        end else

            if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Joint) then begin
                TestField(Name);
                TestField("Registration No");
                TestField("Copy of KRA Pin");
                TestField("Member Registration Fee Receiv");
                TestField("Customer Posting Group");
                TestField("Global Dimension 1 Code");
                TestField("Global Dimension 2 Code");

            end;
    end;

    local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        recipient: List of [Text];
    begin
        SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        Memb.SetFilter(Memb."E-Mail (Personal)", '<>%1', '');
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            if Memb."E-Mail (Personal)" <> '' then
                recipient.Add(Email);
            SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", recipient, 'Membership Application', '', true);
            SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;




    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20]; VarMemberNo: Code[30])
    var
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType."Product Short Name";
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';

        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Name);
        VarTextExtension := '<p>At Vision Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 1550262333007 and any Family Bank Branch via Utility Payment. You will provide your Kingdom Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Kingdom Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Vision Sacco.</p>' +
               '<p>7. Process your salary to your Vision Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.visionsacco.com">www.visionsacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Vision Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'WELCOME TO VISION SACCO';
        VarEmailBody := 'Welcome and Thank you for Joining Vision Sacco. Your Membership Number is ' + VarMemberNo + '. Your Account Numbers are: ' + VarAccountTypes + VarTextExtension + VarTextExtensionII;

        SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;

    local procedure FnUpdateMemberSubAccounts()
    begin
        /*ObjSaccosetup.GET;
        
        //SHARE CAPITAL
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'601');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(HQ)");
                ObjSaccosetup."Share Capital Account No(HQ)":=ObjMembers."Share Capital No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='601';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(NAIV)");
                ObjSaccosetup."Share Capital Account No(NAIV)":=ObjMembers."Share Capital No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='601';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(NKR)");
                  ObjSaccosetup."Share Capital Account No(NKR)":=ObjMembers."Share Capital No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='601';
                  ObjVarBOSAACCount.INSERT;
                  END;
        
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(ELD)");
                    ObjSaccosetup."Share Capital Account No(ELD)":=ObjMembers."Share Capital No";
                    ObjMembers.MODIFY;
                    ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='601';
                    ObjVarBOSAACCount.INSERT;
                    END;
        
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Share Capital No":=INCSTR(ObjSaccosetup."Share Capital Account No(MSA)");
                      ObjSaccosetup."Share Capital Account No(MSA)":=ObjMembers."Share Capital No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Share Capital No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Share Capital";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='601';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        //END SHARE CAPITAL
        
        //DEPOSITS CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'602');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='602';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='602';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='602';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='602';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='602';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //CORPORATE DEPOSITS CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'603');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='603';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='603';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='603';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='603';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='603';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //FOSA SHARES CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'605');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='605';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='605';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='605';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='605';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='605';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //FOSA SHARES CONTRIBUTION
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'607');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(HQ)");
                ObjSaccosetup."Deposits Account No(HQ)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='607';
                ObjVarBOSAACCount.INSERT;
              END;
        
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NAIV)");
                ObjSaccosetup."Deposits Account No(NAIV)":=ObjMembers."Deposits Account No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='607';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(NKR)");
                  ObjSaccosetup."Deposits Account No(NKR)":=ObjMembers."Deposits Account No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='607';
                  ObjVarBOSAACCount.INSERT;
                  END;
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(ELD)");
                    ObjSaccosetup."Deposits Account No(ELD)":=ObjMembers."Deposits Account No";
                    ObjMembers.MODIFY;
                     ObjSaccosetup.MODIFY;
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='607';
                    ObjVarBOSAACCount.INSERT;
                    END;
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Deposits Account No":=INCSTR(ObjSaccosetup."Deposits Account No(MSA)");
                      ObjSaccosetup."Deposits Account No(MSA)":=ObjMembers."Deposits Account No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Deposits Account No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Deposit Contribution";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='607';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
        
        //BENEVOLENT FUND
        
        ObjProductsApp.RESET;
        ObjProductsApp.SETRANGE(ObjProductsApp."Membership Applicaton No","No.");
        ObjProductsApp.SETRANGE(ObjProductsApp."Product Source",ObjProductsApp."Product Source"::BOSA);
        ObjProductsApp.SETRANGE(ObjProductsApp.Product,'606');
        IF ObjProductsApp.FINDSET THEN BEGIN
          ObjMembers.RESET;
          ObjMembers.SETRANGE(ObjMembers."ID No.","ID No.");
          IF ObjMembers.FINDSET THEN BEGIN
            IF "Global Dimension 2 Code"='NAIROBI' THEN BEGIN
              ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(HQ)");
                ObjSaccosetup."BenFund Account No(HQ)":=ObjMembers."Benevolent Fund No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='606';
                ObjVarBOSAACCount.INSERT;
        
              END;
              IF "Global Dimension 2 Code"='NAIVASHA' THEN BEGIN
              ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(NAIV)");
                ObjSaccosetup."BenFund Account No(NAIV)":=ObjMembers."Benevolent Fund No";
                ObjMembers.MODIFY;
                ObjSaccosetup.MODIFY;
        
                ObjVarBOSAACCount.INIT;
                ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                ObjVarBOSAACCount."Account Type":='606';
                ObjVarBOSAACCount.INSERT;
                END;
        
                IF "Global Dimension 2 Code"='NAKURU' THEN BEGIN
                ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(NKR)");
                  ObjSaccosetup."BenFund Account No(NKR)":=ObjMembers."Benevolent Fund No";
                  ObjMembers.MODIFY;
                  ObjSaccosetup.MODIFY;
        
                  ObjVarBOSAACCount.INIT;
                  ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                  ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                  ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                  ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                  ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                  ObjVarBOSAACCount."Account Type":='606';
                  ObjVarBOSAACCount.INSERT;
                  END;
        
                  IF "Global Dimension 2 Code"='ELDORET' THEN BEGIN
                  ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(ELD)");
                    ObjSaccosetup."BenFund Account No(ELD)":=ObjMembers."Benevolent Fund No";
                    ObjMembers.MODIFY;
                    ObjSaccosetup.MODIFY;
        
        
                    ObjVarBOSAACCount.INIT;
                    ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                    ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                    ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                    ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                    ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                    ObjVarBOSAACCount."Account Type":='606';
                    ObjVarBOSAACCount.INSERT;
                    END;
        
                    IF "Global Dimension 2 Code"='MOMBASA' THEN BEGIN
                    ObjMembers."Benevolent Fund No":=INCSTR(ObjSaccosetup."BenFund Account No(MSA)");
                      ObjSaccosetup."BenFund Account No(MSA)":=ObjMembers."Benevolent Fund No";
                      ObjMembers.MODIFY;
                      ObjSaccosetup.MODIFY;
        
                      ObjVarBOSAACCount.INIT;
                      ObjVarBOSAACCount."Account No":=ObjMembers."Benevolent Fund No";
                      ObjVarBOSAACCount."Transaction Type":=ObjVarBOSAACCount."Transaction Type"::"Benevolent Fund";
                      ObjVarBOSAACCount."Member No":=ObjMembers."No.";
                      ObjVarBOSAACCount."Account Name":=ObjMembers.Name;
                      ObjVarBOSAACCount."ID No":=ObjMembers."ID No.";
                      ObjVarBOSAACCount."Account Type":='606';
                      ObjVarBOSAACCount.INSERT;
                      END;
            END;
          END;
          */

    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if "Member Risk Level" <> "member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if "Member Risk Level" = "member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;

    local procedure FnRuninsertBOSAAccountNos(VarMemberNo: Code[30])
    begin
        /*
        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No",VarMemberNo);
        ObjAccounts.SETRANGE(ObjAccounts."Account Type",'SHARECAP');
        ObjAccounts.SETRANGE(ObjAccounts.Status,ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN
          BEGIN
             IF CustomerTable.GET(VarMemberNo) THEN
              BEGIN
                CustomerTable."Share Capital No":=ObjAccounts."No.";
                CustomerTable.MODIFY;
                END;
            END;
        
        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No",VarMemberNo);
        ObjAccounts.SETFILTER(ObjAccounts."Account Type",'=%1','DEPOSITS');
        ObjAccounts.SETRANGE(ObjAccounts.Status,ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN
          BEGIN
             IF CustomerTable.GET(VarMemberNo) THEN
              BEGIN
                CustomerTable."Deposits Account No":=ObjAccounts."No.";
                CustomerTable.MODIFY;
                END;
            END;
        
        ObjAccounts.RESET;
        ObjAccounts.SETRANGE(ObjAccounts."BOSA Account No",VarMemberNo);
        ObjAccounts.SETFILTER(ObjAccounts."Account Type",'=%1','BENFUND');
        ObjAccounts.SETRANGE(ObjAccounts.Status,ObjAccounts.Status::Active);
        IF ObjAccounts.FINDSET THEN
          BEGIN
             IF CustomerTable.GET(VarMemberNo) THEN
              BEGIN
                CustomerTable."Benevolent Fund No":=ObjAccounts."No.";
                CustomerTable.MODIFY;
                END;
            END;
            */

    end;

    protected procedure FnValidatefields(MemberApp: Record "Membership Applications")
    begin
        TestField("ID No.");
        TestField("Phone No.");
        TestField("KRA PIN");
        TestField("First Name");
        TestField("Last Name");
        TestField("Date of Birth");
        TestField("Postal Code");
        TestField("Individual Category");
        TestField("Bank Account No");

    end;



    local procedure FnRunAMLDueDiligenceCheck()
    begin
        TestField("Individual Category");
        TestField("Member Residency Status");
        TestField("Industry Type");
        TestField("Length Of Relationship");
        TestField("International Trade");
        TestField("Electronic Payment");
        TestField("Accounts Type Taken");
        TestField("Cards Type Taken");
        TestField("Others(Channels)");
    end;

    local procedure FnRunCheckDueDiligenceMeasureGeneration()
    var
        ObjDueDiligenceMeasures: Record "Member Due Diligence Measures";
    begin
        ObjDueDiligenceMeasures.Reset;
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Member No", "No.");
        if not ObjDueDiligenceMeasures.Find('-') then begin
            Error('Kindly Generate Due Diligence Measures for this Application before Proceeding');
        end;
    end;

    local procedure FnRunEnsureDueDiligenceMeasureChecked()
    var
        ObjDueDiligenceMeasures: Record "Member Due Diligence Measures";
    begin
        ObjDueDiligenceMeasures.Reset;
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Member No", "No.");
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Due Diligence Done", false);
        if ObjDueDiligenceMeasures.FindSet then begin
            Error('Kindly Ensure All Due Diligence Measures for this Application has been Checked before Creating the Account');
        end;
    end;

    local procedure FnSendKYCUpdateEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20]; VarMemberNo: Code[30])
    var
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType."Product Short Name";
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';

        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Name);
        VarTextExtension := '<p>At Demo Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 1550262333007 and any Family Bank Branch via Utility Payment. You will provide your Demo Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Demo Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Demo Sacco.</p>' +
               '<p>7. Process your salary to your Demo Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.Demosacco.com">www.Demosacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Demo Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'MEMBERSHIP KYC DETAILS UPDATED - ' + VarMemberNo;
        VarEmailBody := '<p>Your Membership KYC Details have successfully been updated. You can now transact on your Accounts without any limits.</p>' +
              '<p>Your Membership Number is ' + VarMemberNo + '. Your Account Numbers are: ' + VarAccountTypes + '</p>' + VarTextExtension + VarTextExtensionII;

        SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;
}

