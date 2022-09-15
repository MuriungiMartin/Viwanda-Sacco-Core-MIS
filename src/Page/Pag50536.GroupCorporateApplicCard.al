#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50536 "Group/Corporate Applic Card"
{
    Editable = true;
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
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;

                        if "Account Category" = "account category"::Corporate then begin
                            Joint2DetailsVisible := true;
                        end;
                        if "Account Category" <> "account category"::Group then begin
                            NumberofMembersEditable := false
                        end else
                            NumberofMembersEditable := true;
                    end;
                }
                field("Name of the Group/Corporate"; "Name of the Group/Corporate")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field(Town; Town)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field(County; County)
                {
                    ApplicationArea = Basic;
                }
                field(District; District)
                {
                    ApplicationArea = Basic;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Location"; "Sub-Location")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Registration"; "Date of Registration")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("No of Members"; "No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field("Group/Corporate Trade"; "Group/Corporate Trade")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Certificate No"; "Certificate No")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("KRA PIN"; "KRA PIN")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("Need a Cheque book"; "Need a Cheque book")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("Application Category"; "Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = AppCategoryEditable;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = CustPostingGroupEdit;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
            group("Communication Info")
            {
                Caption = 'Communication Info';
                Editable = EditableField;
                field("Office Telephone No."; "Office Telephone No.")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("Office Extension"; "Office Extension")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("E-mail Indemnified"; "E-mail Indemnified")
                {
                    ApplicationArea = Basic;
                }
                field("Send E-Statements"; "Send E-Statements")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                    Enabled = EditableField;
                }
                field("Home Address"; "Home Address")
                {
                    ApplicationArea = Basic;
                }
                field("Home Postal Code"; "Home Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = HomeAddressPostalCodeEditable;
                }
                field("Home Town"; "Home Town")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPEditable;
                    ShowMandatory = true;
                }
                field("Contact Person Phone"; "Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPPhoneEditable;
                    ShowMandatory = true;
                }
                field("ContactPerson Relation"; "ContactPerson Relation")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPRelationEditable;
                }
            }
            group("Trade Information")
            {
                Caption = 'Trade Information';
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
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
                        // Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; "Due Diligence Measure")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        //  Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }
                part(Control20; "Member Due Diligence Measure")
                {
                    Caption = 'Due Diligence Measure';
                    SubPageLink = "Member No" = field("No.");
                    SubPageView = sorting("Due Diligence No");
                }
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
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");
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
                    RunObject = Page "Entities Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin
                        SFactory.FnGetEntitiesApplicationAMLRiskRating("No.");

                        /*ObjEntitiesAMLEntries.RESET;
                        ObjEntitiesAMLEntries.SETRANGE(ObjEntitiesAMLEntries."Membership Application No","No.");
                        IF ObjEntitiesAMLEntries.FINDSET THEN
                          PAGE.RUN(51516619);*/

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
                    begin

                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                        if ObjProductsApp.FindSet = false then begin
                            Error('You must select products for the member');
                        end;

                        /*
                        IF "ID No."<>'' THEN BEGIN
                        Cust.RESET;
                        Cust.SETRANGE(Cust."ID No.","ID No.");
                        Cust.SETRANGE(Cust."Customer Type",Cust."Customer Type"::Member);
                        IF Cust.FIND('-') THEN BEGIN
                        IF (Cust."No." <> "No.") AND ("Account Category"="Account Category"::Individual) THEN
                           ERROR('Member has already been created');
                        END;
                        END;
                        */
                        //-------------------Check ID Or Passport---------------------------------------
                        // IF ("ID No."='') AND ("Passport No."='') THEN
                        //ERROR('You Must Specify Either ID or Passport No for the Applicant');
                        //-------------------Check ID Or Passport---------------------------------------


                        if ("Account Category" = "account category"::Individual) then begin
                            TestField(Name);
                            TestField("ID No.");
                            TestField("Mobile Phone No");
                            //TESTFIELD("E-Mail (Personal)");
                            //TESTFIELD("Employer Code");
                            //TESTFIELD("Received 1 Copy Of ID");
                            //TESTFIELD("Copy of Current Payslip");
                            //TESTFIELD("Member Registration Fee Receiv");
                            //TESTFIELD("Copy of KRA Pin");
                            TestField("Customer Posting Group");
                            //TESTFIELD("Global Dimension 1 Code");
                            TestField("Global Dimension 2 Code");
                        end else

                            if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Joint) then begin
                                TestField(Name);
                                //TESTFIELD("Registration No");
                                TestField("Contact Person");
                                TestField("Contact Person Phone");
                                TestField("Date of Registration");
                                //TESTFIELD("Group/Corporate Trade");
                                TestField("Customer Posting Group");
                                //TESTFIELD("Global Dimension 1 Code");
                                TestField("Global Dimension 2 Code");
                                TestField("Contact Person Phone");
                                TestField("Monthly Contribution");

                            end;

                        /*IF ("Account Category"="Account Category"::Single)OR ("Account Category"="Account Category"::Junior)OR ("Account Category"="Account Category"::Joint)  THEN BEGIN
                        NOkApp.RESET;
                        NOkApp.SETRANGE(NOkApp."Account No","No.");
                        IF NOkApp.FIND('-')=FALSE THEN BEGIN
                        ERROR('Please Insert Next 0f kin Information');
                        END;
                        END;*/

                        if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Joint) then begin
                            ObjAccountSignApp.Reset;
                            ObjAccountSignApp.SetRange(ObjAccountSignApp."Account No", "No.");
                            if ObjAccountSignApp.Find('-') = false then begin
                                Error('Please insert Account Signatories');
                            end;
                        end;



                        if Status <> Status::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::"Account Opening";
                        Table_id := Database::"Membership Applications";
                        //IF Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;

                        if WkFlwIntegration.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            WkFlwIntegration.OnSendMembershipApplicationForApproval(Rec);



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
                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            WkFlwIntegration.OnCancelMembershipApplicationApprovalRequest(Rec);
                        Status := Status::Open;
                        Modify;
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
                action("Create Account ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Accounts';
                    Enabled = EnableCreateMember;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ObjAccountType: Record "Account Types-Saving Products";
                        VarAccounts: Text;
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');
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
                            Error('You must select Membership product for a new Member for them to be assigned a Member No.');
                        end;



                        if Confirm('Are you sure you want to create account application?', false) = true then begin


                            ObjProductsApp.Reset;
                            ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                            ObjProductsApp.SetRange(ObjProductsApp."Product Source", ObjProductsApp."product source"::BOSA);
                            ObjProductsApp.SetRange(ObjProductsApp.Product, 'MEMBERSHIP');
                            if ObjProductsApp.FindSet then begin
                                repeat

                                    //================================================================================================Back office Account
                                    /* IF "Certificate No"<>'' THEN BEGIN
                                     ObjCust.RESET;
                                     ObjCust.SETRANGE(ObjCust."Certificate No","Certificate No");
                                     ObjCust.SETRANGE(ObjCust."Customer Type",ObjCust."Customer Type"::Member);
                                     IF ObjCust.FIND('-') THEN BEGIN
                                        ERROR('Member has already been created');
                                     END;
                                     END;*/

                                    ObjSaccosetup.Get();

                                    ObjMemberNoseries.Reset;
                                    ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                    ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                                    if ObjMemberNoseries.FindSet then begin
                                        VarNewMembNo := ObjMemberNoseries."Account No";
                                    end;



                                    //Create BOSA account
                                    ObjCust."No." := Format(VarNewMembNo);
                                    ObjCust.Name := Name;
                                    ObjCust.Address := Address;
                                    ObjCust."Post Code" := "Postal Code";
                                    ObjCust.County := County;
                                    ObjCust.City := City;
                                    ObjCust."Country/Region Code" := "Country/Region Code";
                                    ObjCust."Phone No." := "Mobile Phone No";
                                    ObjCust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                    ObjCust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                    ObjCust."Customer Posting Group" := "Customer Posting Group";
                                    ObjCust."Registration Date" := Today;
                                    ObjCust."Mobile Phone No" := "Mobile Phone No";
                                    ObjCust.Status := ObjCust.Status::Active;
                                    ObjCust."Employer Code" := "Employer Code";
                                    ObjCust."Date of Birth" := "Date of Birth";
                                    ObjCust.Piccture := Picture;
                                    ObjCust.Signature := Signature;
                                    ObjCust."Station/Department" := "Station/Department";
                                    ObjCust."E-Mail" := "E-Mail (Personal)";
                                    ObjCust.Location := Location;
                                    ObjCust.Title := Title;
                                    ObjCust."Home Address" := "Home Address";
                                    ObjCust."Home Postal Code" := "Home Postal Code";
                                    ObjCust."Home Town" := "Home Town";
                                    ObjCust."Recruited By" := "Recruited By";
                                    ObjCust."Contact Person" := "Contact Person";
                                    ObjCust."ContactPerson Relation" := "ContactPerson Relation";
                                    ObjCust."ContactPerson Occupation" := "ContactPerson Occupation";
                                    ObjCust."Member Share Class" := "Member Share Class";
                                    ObjCust."Member's Residence" := "Member's Residence";
                                    ObjCust."Employer Address" := "Employer Address";
                                    ObjCust."Member House Group" := "Member House Group";
                                    ObjCust."Member House Group Name" := "Member House Group Name";
                                    ObjCust."Nature Of Business" := "Nature Of Business";
                                    ObjCust."Date of Employment" := "Date of Employment";
                                    ObjCust."Position Held" := "Position Held";
                                    ObjCust.Industry := Industry;
                                    ObjCust."Business Name" := "Business Name";
                                    ObjCust."Physical Business Location" := "Physical Business Location";
                                    ObjCust."Year of Commence" := "Year of Commence";
                                    ObjCust."Identification Document" := "Identification Document";
                                    ObjCust."Referee Member No" := "Referee Member No";
                                    ObjCust."Referee Name" := "Referee Name";
                                    ObjCust."Referee ID No" := "Referee ID No";
                                    ObjCust."Referee Mobile Phone No" := "Referee Mobile Phone No";
                                    ObjCust."Email Indemnified" := "E-mail Indemnified";
                                    ObjCust."Created By" := UserId;
                                    ObjCust."Member Needs House Group" := "Member Needs House Group";
                                    ObjCust."Account Category" := "Account Category";
                                    ObjCust."Name of the Group/Corporate" := "Name of the Group/Corporate";
                                    ObjCust."Post Code" := "Postal Code";
                                    ObjCust."Date of Registration" := "Date of Registration";
                                    ObjCust."No of Members" := "No of Members";
                                    ObjCust."Group/Corporate Trade" := "Group/Corporate Trade";
                                    ObjCust."Certificate No" := "Certificate No";
                                    ObjCust."Recruited By" := "Recruited By";

                                    if ObjCust."Account Category" = ObjCust."account category"::Corporate then
                                        ObjCust."Account Category" := "Account Category";

                                    ObjCust."Office Branch" := "Office Branch";
                                    ObjCust.Department := Department;
                                    ObjCust.Occupation := Occupation;
                                    ObjCust.Designation := Designation;
                                    ObjCust."Bank Code" := "Bank Code";
                                    ObjCust."Bank Branch Code" := "Bank Name";
                                    ObjCust."Bank Account No." := "Bank Account No";
                                    //**
                                    ObjCust."Sub-Location" := "Sub-Location";
                                    ObjCust.District := District;
                                    ObjCust."Payroll No" := "Payroll No";
                                    ObjCust."ID No." := "ID No.";
                                    ObjCust."Mobile Phone No" := "Mobile Phone No";
                                    ObjCust."Marital Status" := "Marital Status";
                                    ObjCust."Customer Type" := ObjCust."customer type"::Member;
                                    ObjCust.Gender := Gender;

                                    ObjCust.Piccture := Picture;
                                    ObjCust.Signature := Signature;

                                    ObjCust."Monthly Contribution" := "Monthly Contribution";
                                    ObjCust."Contact Person" := "Contact Person";
                                    ObjCust."Contact Person Phone" := "Contact Person Phone";
                                    ObjCust."ContactPerson Relation" := "ContactPerson Relation";
                                    ObjCust."Recruited By" := "Recruited By";
                                    ObjCust."ContactPerson Occupation" := "ContactPerson Occupation";
                                    ObjCust."Village/Residence" := "Village/Residence";
                                    ObjCust.Pin := "KRA PIN";
                                    ObjCust."Account Category" := "Account Category";
                                    //========================================================================Member Risk Rating
                                    ObjCust."Individual Category" := "Individual Category";
                                    ObjCust.Entities := Entities;
                                    ObjCust."Member Residency Status" := "Member Residency Status";
                                    ObjCust."Industry Type" := "Industry Type";
                                    ObjCust."Length Of Relationship" := "Length Of Relationship";
                                    ObjCust."International Trade" := "International Trade";
                                    ObjCust."Electronic Payment" := "Electronic Payment";
                                    ObjCust."Accounts Type Taken" := "Accounts Type Taken";
                                    ObjCust."Cards Type Taken" := "Cards Type Taken";
                                    ObjCust.Insert(true);
                                    //========================================================================End Member Risk Rating

                                    ObjNextOfKinApp.Reset;
                                    ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", "No.");
                                    if ObjNextOfKinApp.Find('-') then begin
                                        repeat
                                            ObjNextOfKin.Init;
                                            ObjNextOfKin."Account No" := ObjCust."No.";
                                            ObjNextOfKin.Name := ObjNextOfKinApp.Name;
                                            ObjNextOfKin.Relationship := ObjNextOfKinApp.Relationship;
                                            ObjNextOfKin.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                            ObjNextOfKin."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                            ObjNextOfKin.Address := ObjNextOfKinApp.Address;
                                            ObjNextOfKin.Telephone := ObjNextOfKinApp.Telephone;
                                            ObjNextOfKin.Email := ObjNextOfKinApp.Email;
                                            ObjNextOfKin."ID No." := ObjNextOfKinApp."ID No.";
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
                                            ObjMemberAgent.Init;
                                            ObjMemberAgent."Account No" := ObjCust."No.";
                                            ;
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
                                    VarBOSAACC := ObjCust."No.";
                                until ObjProductsApp.Next = 0;
                            end;
                        end;
                        //==================================================================================================End Back Office Account

                        //==================================================================================================Front Office Accounts
                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1&<>%2', 'MEMBERSHIP', '');
                        if ObjProductsApp.FindSet then begin
                            repeat

                                ObjMemberNoseries.Reset;
                                ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                                if ObjMemberNoseries.FindSet then begin
                                    VarAcctNo := ObjMemberNoseries."Account No";
                                end;

                                /*IF "Certificate No"<>'' THEN
                                  BEGIN
                                ObjAccounts.RESET;
                                ObjAccounts.SETRANGE(ObjAccounts."Certificate No","Certificate No");
                                ObjAccounts.SETRANGE(ObjAccounts."Account Type",ObjProductsApp.Product);
                                IF ObjAccounts.FINDSET THEN BEGIN
                                  ERROR('The Member has an existing %1',ObjAccounts."Account Type");
                                  END;
                                  END;*/

                                //===================================================================Create FOSA account
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
                                ObjAccounts."BOSA Account No" := ObjCust."No.";
                                //ObjAccounts.Picture:=Picture;
                                //ObjAccounts.Signature:=Signature;
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
                                ObjAccounts."Certificate No" := "Certificate No";
                                ObjAccounts."Registration Date" := "Registration Date";
                                ObjAccounts."Created By" := UserId;

                                if ObjCust."Account Category" = ObjCust."account category"::Corporate then
                                    ObjAccounts."Joint Account Name" := "First Name" + ' &' + "First Name2" + ' &' + "First Name3" + 'JA';

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


                                    //Update BOSA with FOSA Account
                                    if ObjCust.Get(VarBOSAACC) then begin
                                        ObjCust."FOSA Account No." := VarAcctNo;
                                        ObjCust.Modify;
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
                                        ObjAccountAgents.Init;
                                        ObjAccountAgents."Account No" := VarAcctNo;
                                        ObjAccountAgents.Names := ObjMemberAppAgent.Names;
                                        ObjAccountAgents."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                        ObjAccountAgents."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                        ObjAccountAgents."ID No." := ObjMemberAppAgent."ID No.";
                                        ObjAccountAgents."BOSA No." := ObjMemberAppAgent."BOSA No.";
                                        ObjAccountAgents."Email Address" := ObjMemberAppAgent."Email Address";
                                        ObjAccountAgents."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                        ObjAccountAgents."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                        ObjAccountAgents."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                        ObjAccountAgents."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                        ObjAccountAgents."Must Sign" := ObjMemberAppAgent."Must Sign";
                                        ObjAccountAgents."Must be Present" := ObjMemberAppAgent."Must be Present";
                                        ObjAccountAgents."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                        ObjAccountAgents.Insert;

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
                                                ObjAccountSign."Mobile No" := ObjAccountSignApp."Mobile No.";
                                                ObjAccountSign."Member No." := ObjAccountSignApp."BOSA No.";
                                                ObjAccountSign."Email Address" := ObjAccountSignApp."Email Address";
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
                                        //GenJournalLine.INSERT;



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
                        Message('You have successfully Registered a New Sacco Member. Membership No=%1.The Member will be notifed via an SMS', ObjCust."No.");
                        //==========================================================================================================End Front Office Accounts



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
                            SFactory.FnSendSMS('MEMBERAPP', 'You member Registration has been completed. Your Member No is ' + VarBOSAACC + ' and your Accounts are: ' + VarAccounts,
                            VarBOSAACC, "Mobile Phone No");
                        end;

                        //======================================================================================================Send Email
                        if ObjGenSetUp."Send Membership Reg Email" = true then begin
                            FnSendRegistrationEmail("No.", "E-Mail (Personal)", "ID No.");
                        end;

                        Created := true;

                        CalcFields("Assigned No.");
                        FnRuninsertBOSAAccountNos("Assigned No.");//========================================================================Update Membership Account with BOSA Account Nos

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControls();
        EditableField := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;

        if (Rec.Status = Status::Approved) and (Rec."Assigned No." = '') then
            EnableCreateMember := true;
        if Status <> Status::Open then
            EditableField := false;
    end;

    trigger OnAfterGetRecord()
    begin
        "Self Recruited" := true;
        EmployedEditable := false;
        ContractingEditable := false;
        OthersEditable := false;

        if "Account Category" <> "account category"::Corporate then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;




        if "Account Category" <> "account category"::Group then begin
            NumberofMembersEditable := false
        end else
            NumberofMembersEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Responsibility Centre" := UserMgt.GetSalesFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GenSetUp.Get();
        "Monthly Contribution" := GenSetUp."Corporate Minimum Monthly Cont";
        "Account Category" := "account category"::Group;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetSalesFilter <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Centre", UserMgt.GetSalesFilter);
            FilterGroup(0);
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Nominee";
        MAccountSign: Record "Member Account Signatories";
        PAccountSign: Record "FOSA Account Sign. Details";
        ObjAccountSignApp: Record "Member App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Nominee";
        NOKBOSA: Record "Members Next of Kin";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Next of Kin";
        PictureExists: Boolean;
        text001: label 'Status must be open';
        UserMgt: Codeunit "User Setup Management";
        NotificationE: Codeunit Mail;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
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
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        NewMembNo: Code[30];
        Saccosetup: Record "Sacco No. Series";
        NOkApp: Record "Member App Nominee";
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
        DataSheet: Record "Data Sheet Main";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ProductsApp: Record "Membership Reg. Products Appli";
        NextofKinFOSA: Record "FOSA Account NOK Details";
        NumberofMembersEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableCreateMember: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to  Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        EditableField: Boolean;
        RefereeEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        ObjAccountAppAgent: Record "Account Agents App Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjMemberAppAgent: Record "Member Agents App Details";
        ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        WkFlwIntegration: codeunit WorkflowIntegration;
        ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record Customer;
        ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        CompInfo: Record "Company Information";
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjCust: Record Customer;
        ObjSaccosetup: Record "Sacco General Set-Up";
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarNewMembNo: Code[30];
        ObjNextOfKinApp: Record "Member App Nominee";
        ObjNextOfKin: Record "Members Next of Kin";
        ObjAccountSign: Record "FOSA Account Sign. Details";
        VarAcctNo: Code[30];
        VarBOSAACC: Code[30];
        ObjAccounts: Record Vendor;
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjGenSetUp: Record "Sacco General Set-Up";
        VarAccountDescription: Text;
        VarAccountTypes: Code[250];
        ObjAccountType: Record "Account Types-Saving Products";
        VarMemberName: Text;
        SurestepFactory: Codeunit "SURESTEP Factory";
        VarTextExtension: Text;
        VarTextExtensionII: Text;
        VarEmailSubject: Text;
        VarEmailBody: Text;
        ObjNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarDocumentNo: Code[30];
        CoveragePercentStyle: Text;
        ObjEntitiesAMLEntries: Record "Entities Customer Risk Rate";


    procedure UpdateControls()
    begin

        if Status = Status::Approved then begin
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
            EmployerCodeEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
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
            EmployerCodeEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if Status = Status::Open then begin
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
            EmployerCodeEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
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

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := "No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
        SMSMessage."Telephone No" := "Mobile Phone No";
        if "Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := "No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBREG';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + BOSAACC + ' Name ' + Name + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
        SMSMessage."Telephone No" := "Mobile Phone No";
        if "Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure UpdateViewLogEntries()
    begin
        /*ViewLog.INIT;
        ViewLog."Entry No.":=ViewLog."Entry No."+1;
        ViewLog."User ID":=USERID;
        ViewLog."Table No.":=51516364;
        ViewLog."Table Caption":='Members Register';
        ViewLog.Date:=TODAY;
        ViewLog.Time:=TIME;
        */

    end;

    local procedure FnCheckfieldrestriction()
    begin
        if ("Account Category" = "account category"::Individual) then begin
            //CALCFIELDS(Picture,Signature);
            TestField(Name);
            TestField("ID No.");
            TestField("Mobile Phone No");
            //TESTFIELD("Employer Code");
            //TESTFIELD("Personal No");
            TestField("Monthly Contribution");
            TestField("Member's Residence");
            TestField(Gender);
            TestField("Employment Info");
            TestField("Address 2");

            //TESTFIELD("Copy of Current Payslip");
            //TESTFIELD("Member Registration Fee Receiv");
            TestField("Customer Posting Group");
            TestField("Global Dimension 1 Code");
            //TESTFIELD("Global Dimension 2 Code");
            //TESTFIELD("Contact Person");
            //TESTFIELD("Contact Person Phone");
            //IF Picture=0 OR Signature=0 THEN
            //ERROR(Insert )
        end else

            if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Joint) then begin
                TestField(Name);
                TestField("Registration No");
                TestField("Copy of KRA Pin");
                TestField("Member Registration Fee Receiv");
                ///TESTFIELD("Account Category");
                TestField("Customer Posting Group");
                TestField("Global Dimension 1 Code");
                TestField("Global Dimension 2 Code");
                //TESTFIELD("Copy of constitution");
                TestField("Contact Person");
                TestField("Contact Person Phone");

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
        Recipient: list of [Text];
    begin
        SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            if Memb."E-Mail (Personal)" <> '' then
                Recipient.Add(Email);
            SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Membership Application', '', true);
            SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
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
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType.Description;
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';


        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Name);
        VarTextExtension := '<p>At Kingdom Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 1550262333007 and any Family Bank Branch via Utility Payment. You will provide your Kingdom Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Kingdom Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Kingdom Sacco.</p>' +
               '<p>7. Process your salary to your Kingdom Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.kingdomsacco.com">www.kingdomsacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Kingdom Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'WELCOME TO KINGDOM SACCO';
        VarEmailBody := 'Welcome and Thank you for Joining Kingdom Sacco. Your Membership Number is ' + VarBOSAACC + '. Your Account Numbers are: ' + VarAccountTypes + VarTextExtension + VarTextExtensionII;

        SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;

    local procedure FnUpdateMemberSubAccounts()
    begin
        Saccosetup.Get();

        //SHARE CAPITAL
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '601');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(HQ)");
                    Saccosetup."Share Capital Account No(HQ)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(NAIV)");
                    Saccosetup."Share Capital Account No(NAIV)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(NKR)");
                    Saccosetup."Share Capital Account No(NKR)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(ELD)");
                    Saccosetup."Share Capital Account No(ELD)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(MSA)");
                    Saccosetup."Share Capital Account No(MSA)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;
        //END SHARE CAPITAL

        //DEPOSITS CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '602');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //CORPORATE DEPOSITS CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '603');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //FOSA SHARES CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '605');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //FOSA SHARES CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '607');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //BENEVOLENT FUND

        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '606');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", "ID No.");
            if ObjMembers.FindSet then begin
                if "Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(HQ)");
                    Saccosetup."BenFund Account No(HQ)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;

                end;
                if "Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(NAIV)");
                    Saccosetup."BenFund Account No(NAIV)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(NKR)");
                    Saccosetup."BenFund Account No(NKR)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(ELD)");
                    Saccosetup."BenFund Account No(ELD)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;


                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if "Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(MSA)");
                    Saccosetup."BenFund Account No(MSA)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

    end;

    local procedure FnRuninsertBOSAAccountNos(VarMemberNo: Code[30])
    begin

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetRange(ObjAccounts."Account Type", '601');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Share Capital No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1|%2', '602', '603');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Deposits Account No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '606');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Benevolent Fund No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;


        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '605');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."FOSA Shares Account No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;
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

