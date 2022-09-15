#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50243 "Membership Appl. - Created"
{
    CardPageID = "Membership Application Card";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";
    SourceTableView = where("Incomplete Application" = filter(false),
                            "Account Category" = filter(Individual | Joint | Corporate),
                            "Others Details" = filter(<> 'Self'),
                            Created = filter(true),
                            "Online Application" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Appl. No.';
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; "Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Name';
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                }
                field("Final Approver"; "Final Approver")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved By';
                }
            }
        }
        area(factboxes)
        {
            part(Control12; "Member Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control3; "Member Signature-App")
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
                action("Nominee Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = Name = const('name');
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755012)
                {
                    Caption = '-';
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
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');
                        TestField("Monthly Contribution");

                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                        if ObjProductsApp.FindSet = false then begin
                            Error('You must select products for the member');
                        end;


                        if Confirm('Are you sure you want to create account application?', false) = true then begin


                            ObjProductsApp.Reset;
                            ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", "No.");
                            ObjProductsApp.SetRange(ObjProductsApp."Product Source", ObjProductsApp."product source"::BOSA);
                            ObjProductsApp.SetRange(ObjProductsApp.Product, 'MEMBERSHIP');
                            if ObjProductsApp.FindSet then begin
                                repeat

                                    //================================================================================================Back office Account
                                    if "ID No." <> '' then begin
                                        ObjCust.Reset;
                                        ObjCust.SetRange(ObjCust."ID No.", "ID No.");
                                        ObjCust.SetRange(ObjCust."Customer Type", ObjCust."customer type"::Member);
                                        if ObjCust.Find('-') then begin
                                            Error('Member has already been created');
                                        end;
                                    end;

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
                                    ObjCust.County := City;
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


                                    //*****************************to Sort Joint
                                    ObjCust."Name 2" := "Name 2";
                                    ObjCust."Address3-Joint" := Address3;
                                    ObjCust."Postal Code 2" := "Postal Code 2";
                                    ObjCust."Home Postal Code2" := "Home Postal Code2";
                                    ObjCust."Home Town2" := "Home Town2";
                                    ObjCust."ID No.2" := "ID No.2";
                                    ObjCust."Passport 2" := "Passport 2";
                                    ObjCust.Gender2 := Gender2;
                                    ObjCust."Marital Status2" := "Marital Status2";
                                    ObjCust."E-Mail (Personal3)" := "E-Mail (Personal2)";
                                    ObjCust."Employer Code2" := "Employer Code2";
                                    ObjCust."Employer Name2" := "Employer Name2";
                                    ObjCust."Picture 2" := "Picture 2";
                                    ObjCust."Signature  2" := "Signature  2";


                                    ObjCust."Name 3" := "Name 3";
                                    ObjCust."Address3-Joint" := Address4;
                                    ObjCust."Postal Code 3" := "Postal Code 3";
                                    ObjCust."Home Postal Code3" := "Home Postal Code3";
                                    ObjCust."Mobile No. 4" := "Mobile No. 4";
                                    ObjCust."Home Town3" := "Home Town3";
                                    ObjCust."ID No.3" := "ID No.3";
                                    ObjCust."Passport 3" := "Passport 3";
                                    ObjCust.Gender3 := Gender3;
                                    ObjCust."Marital Status3" := "Marital Status3";
                                    ObjCust."E-Mail (Personal3)" := "E-Mail (Personal3)";
                                    ObjCust."Employer Code3" := "Employer Code3";
                                    ObjCust."Employer Name3" := "Employer Name3";
                                    ObjCust."Picture 3" := "Picture 3";
                                    ObjCust."Signature  3" := "Signature  3";
                                    ObjCust."Member Parish Name 3" := "Member Parish Name 3";
                                    ObjCust."Member Parish Name 3" := "Member Parish Name 3";
                                    if ObjCust."Account Category" = ObjCust."account category"::Corporate then
                                        ObjCust."Joint Account Name" := "First Name" + '& ' + "First Name2" + '& ' + "First Name3" + 'JA';
                                    ObjCust."Account Category" := "Account Category";

                                    //===================================================================================End Joint Account Details

                                    //**
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
                                                    //ObjAccountSign."Mobile No.":=ObjAccountSignApp."Mobile No.";
                                                    ObjAccountSign.Insert;
                                                end;
                                            end;
                                        until ObjAccountSignApp.Next = 0;
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
                        //ObjProductsApp.SETFILTER(ObjProductsApp."Product Source",'<>%1',ObjProductsApp."Product Source"::BOSA);
                        ObjProductsApp.SetFilter(ObjProductsApp.Product, '<>%1', 'MEMBERSHIP');
                        if ObjProductsApp.FindSet then begin
                            repeat

                                ObjMemberNoseries.Reset;
                                ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                                if ObjMemberNoseries.FindSet then begin
                                    VarAcctNo := ObjMemberNoseries."Account No";
                                end;

                                ObjAccounts.Reset;
                                ObjAccounts.SetRange(ObjAccounts."ID No.", "ID No.");
                                ObjAccounts.SetRange(ObjAccounts."Account Type", ObjProductsApp.Product);
                                if ObjAccounts.FindSet then begin
                                    Error('The Member has an existing %1', ObjAccounts."Account Type");
                                end;

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
                                // ObjAccounts.Picture:=Picture;
                                // ObjAccounts.Signature:=Signature;
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
                                if ObjCust."Account Category" = ObjCust."account category"::Corporate then
                                    ObjAccounts."Joint Account Name" := "First Name" + ' ' + "First Name2";


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
                                ObjAccounts."Member Parish Name 3" := "Member Parish Name 3";
                                ObjAccounts."Member Parish Name 3" := "Member Parish Name 3";
                                if ObjCust."Account Category" = ObjCust."account category"::Corporate then
                                    ObjAccounts."Joint Account Name" := "First Name" + ' &' + "First Name2" + ' &' + "First Name3" + 'JA';

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
                            SFactory.FnSendSMS('MEMBERAPP', 'You member Registration has been completed.', VarBOSAACC, "Mobile Phone No");
                        end;

                        //======================================================================================================Send Email
                        if ObjGenSetUp."Send Membership Reg Email" = true then begin
                            FnSendRegistrationEmail("No.", "E-Mail (Personal)", "ID No.", VarBOSAACC);
                        end;
                        Created := true;

                        CalcFields("Assigned No.");
                        FnRuninsertBOSAAccountNos("Assigned No.");//========================================================================Update Membership Account with BOSA Account Nos
                    end;
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
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        GenSetUp.Get();

                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        if ProductsApp.FindSet = false then begin
                            Error('You must select products for the member');
                        end;

                        //Check of Member Already Exists
                        if "ID No." <> '' then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", "ID No.");
                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin
                                if (Cust."No." <> "No.") and ("Account Category" = "account category"::Individual) and (Cust.Status = Cust.Status::Active) then
                                    Error('Member has already been created');
                            end;
                        end;


                        //****************Check Next of Kin Info***************
                        if ("Account Category" = "account category"::Individual) then begin
                            ObjNOkApp.Reset;
                            ObjNOkApp.SetRange(ObjNOkApp."Account No", "No.");
                            if ObjNOkApp.Find('-') = false then begin
                                Error('Please Insert Next 0f kin Information');
                            end;
                        end;


                        //****************Check if there is any product Selected***************
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        if ProductsApp.Find('-') = false then begin
                            Error('Please Select Products to be Openned');
                        end;



                        // if ApprovalsMgmt.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                        //         ApprovalsMgmt.OnSendMembershipApplicationForApproval(Rec);

                        /*//Application Send SMS*********************************
                        IF GenSetUp."Send Membership App SMS"=TRUE THEN BEGIN
                          SFactory.FnSendSMS('MEMBERAPP','Dear Member your application has been received and going through approval',BOSAACC,"Mobile Phone No");
                          END;
                        
                        //Application Send Email********************************
                        IF GenSetUp."Send Membership App Email"=TRUE THEN BEGIN
                        FnSendReceivedApplicationEmail("No.","E-Mail (Personal)","ID No.");
                        END;*/

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
                            //ApprovalsMgmt.OnCancelMembershipApplicationApprovalRequest(Rec);
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
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;

        if (Rec.Status = Status::Approved) and (Rec."Assigned No." = '') then
            EnableCreateMember := true;
    end;

    var
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Nafaka Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>NAFAKA SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to  Nafaka Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>NAFAKA SACCO LTD</b></p>';
        StatusPermissions: Record "Status Change Permision";
        ObjCust: Record Customer;
        ObjAccounts: Record Vendor;
        VarAcctNo: Code[20];
        ObjNextOfKinApp: Record "Member App Nominee";
        ObjAccountSign: Record "FOSA Account Sign. Details";
        ObjAccountSignApp: Record "Member Account Signatories";
        ObjAcc: Record Vendor;
        UsersID: Record User;
        ObjNok: Record "Member App Nominee";
        ObjNOKBOSA: Record "Members Next of Kin";
        VarBOSAACC: Code[20];
        ObjNextOfKin: Record "Members Next of Kin";
        VarPictureExists: Boolean;
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
        GenSetUp: Record "Sacco General Set-Up";
        ProductsApp: Record "Membership Reg. Products Appli";
        Cust: Record Customer;


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
            //TESTFIELD("Employer Code");
            //TESTFIELD("Personal No");
            TestField("Monthly Contribution");
            TestField("Member's Residence");
            TestField(Gender);
            TestField("Employment Info");
            TestField("Address 2");
            TestField("KRA PIN");

            //TESTFIELD("Copy of Current Payslip");
            //TESTFIELD("Member Registration Fee Receiv");
            TestField("Customer Posting Group");
            //TESTFIELD("Global Dimension 1 Code");
            //TESTFIELD("Global Dimension 2 Code");
            //TESTFIELD("Contact Person");
            //TESTFIELD("Contact Person Phone");
            //IF Picture=0 OR Signature=0 THEN
            //ERROR(Insert )
            TestField(Picture);
            TestField(Signature);
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
        Recipient: list of [text];
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
                Recipient.Add(Email);
            SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Membership Application', '', true);
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
        VarAccountTypes := '';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType.Description;
                end;

                VarAccountTypes := VarAccountTypes + '<br> - ' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription);
            until ObjAccounts.Next = 0;
        end;


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
        VarEmailBody := 'Welcome and Thank you for Joining Kingdom Sacco. Your Membership Number is ' + VarMemberNo + '. Your Account Numbers are: ' + VarAccountTypes + VarTextExtension + VarTextExtensionII;

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
}

