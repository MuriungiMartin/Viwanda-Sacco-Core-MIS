#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50431 "Member Account Appl. Card"
{
    Caption = 'Account Applications';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "FOSA Account Applicat. Details";

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
                    Caption = 'Application No';
                    Editable = false;
                }
                field("BOSA Account No"; "BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = BOSAnoEditable;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;

                    trigger OnValidate()
                    begin
                        Name := UpperCase(Name);
                    end;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;

                    trigger OnValidate()
                    begin
                        Address := UpperCase(Address);
                    end;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                    Editable = PostCodeEditable;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                    Editable = CityEditable;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CityEditable;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileNoEditable;

                    trigger OnValidate()
                    begin
                        "Mobile Phone No" := UpperCase("Mobile Phone No");
                    end;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;

                    trigger OnValidate()
                    begin
                        "E-Mail" := UpperCase("E-Mail");
                    end;
                }
                field("Identification Document"; "Identification Document")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;

                    trigger OnValidate()
                    begin
                        Acc.Reset;
                        Acc.SetRange(Acc."ID No.", "ID No.");
                        Acc.SetRange(Acc."Account Type", "Account Type");
                        Acc.SetRange(Acc.Status, Acc.Status::Active);
                        if Acc.Find('-') then
                            Error('Account already created.');
                    end;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = PassPortNoEditable;
                }
                field("Staff No"; "Staff No")
                {
                    ApplicationArea = Basic;
                    Editable = StaffNoEditable;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditable;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplicationDateEditable;
                    Importance = Additional;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = AccountTypeEditable;

                    trigger OnValidate()
                    begin

                        if ("Account Type" <> 'FD201') or ("Account Type" <> 'JEWEL') then begin
                            ParentEditable := false;
                            SavingsEditable := false;
                        end;

                        Accounts.Reset;
                        Accounts.SetRange(Accounts."BOSA Account No", "BOSA Account No");
                        Accounts.SetRange(Accounts."Account Type", 'FS151');
                        if Accounts.Find('-') then begin
                            CurrentAcc := Accounts."No.";
                        end;


                        if ("Account Type" = 'FD201') then begin
                            ParentEditable := false;
                            "Savings Account No." := CurrentAcc;
                            SavingsEditable := true;
                        end else
                            if ("Account Type" = 'JEWEL') then begin
                                ParentEditable := true;
                                SavingsEditable := false;
                            end;
                    end;
                }
                field("Account Type Name"; "Account Type Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = AccountCategoryEditable;
                }
                field("Current Account No."; "Savings Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account No.';
                    Editable = SavingsAccountEditable;
                    Visible = true;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = SigningInstructionEditable;
                }
                field("Issue Piggy Bank"; "Issue Piggy Bank")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Caption = 'ACTIVITY';
                    ApplicationArea = Basic;
                    Editable = SigningInstructionEditable;
                    Importance = Additional;
                    Visible = true;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Caption = 'BRANCH CODE';
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Additional;
                    VISIBLE = TRUE;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = RecruitedEditable;
                }
                field("Fixed Deposit Type"; "Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("FD Maturity Date"; "FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control26; "Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentInfoEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if "Employment Info" = "employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false;
                            PositionHeldEditable := true;
                            EmploymentDateEditable := true;
                            EmployerAddressEditable := true;
                            NatureofBussEditable := false;
                            IndustryEditable := false;
                            BusinessNameEditable := false;
                            PhysicalBussLocationEditable := false;
                            YearOfCommenceEditable := false;



                        end else
                            if "Employment Info" = "employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                                PositionHeldEditable := false;
                                EmploymentDateEditable := false;
                                EmployerAddressEditable := false;
                                NatureofBussEditable := false;
                                IndustryEditable := false;
                                BusinessNameEditable := false;
                                PhysicalBussLocationEditable := false;
                                YearOfCommenceEditable := false;
                            end else
                                if "Employment Info" = "employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false;
                                    PositionHeldEditable := false;
                                    EmploymentDateEditable := false;
                                    EmployerAddressEditable := false
                                end else
                                    if "Employment Info" = "employment info"::"Self-Employed" then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false;
                                        NatureofBussEditable := true;
                                        IndustryEditable := true;
                                        BusinessNameEditable := true;
                                        PhysicalBussLocationEditable := true;
                                        YearOfCommenceEditable := true;
                                        PositionHeldEditable := false;
                                        EmploymentDateEditable := false;
                                        EmployerAddressEditable := false

                                    end;



                        /*
                        IF "Identification Document"="Identification Document"::"Nation ID Card" THEN BEGIN
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
                field("Expected Monthly Income"; "Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyIncomeEditable;
                }
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
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
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
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = PhoneEditable;

                    trigger OnValidate()
                    begin
                        "Phone No." := UpperCase("Phone No.");
                    end;
                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page"; "Home Page")
                {
                    ApplicationArea = Basic;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        ICPartnerCodeOnAfterValidate;
                    end;
                }
                field("Home Address"; "Home Address")
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
                field(Contact; Contact)
                {
                    ApplicationArea = Basic;
                    Caption = 'ContactPerson Name';
                    Editable = ContactPEditable;

                    trigger OnValidate()
                    begin
                        ContactOnAfterValidate;
                        Contact := UpperCase(Contact);
                    end;
                }
                field("ContactPerson Relation"; "ContactPerson Relation")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPRelationEditable;

                    trigger OnValidate()
                    begin
                        "ContactPerson Relation" := UpperCase("ContactPerson Relation");
                    end;
                }
                field("ContacPerson Occupation"; "ContacPerson Occupation")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPOccupationEditable;

                    trigger OnValidate()
                    begin
                        "ContacPerson Occupation" := UpperCase("ContacPerson Occupation");
                    end;
                }
                field("ContacPerson Phone"; "ContacPerson Phone")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPPhoneEditable;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000025; "Vendor Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = MobileNoEditable;
                Enabled = MobileNoEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000024; "Vendor Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                Editable = MobileNoEditable;
                Enabled = MobileNoEditable;
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
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product App Nominee Details";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    // RunObject = Page "Product App Signatories";
                    // RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Account Agent App List";
                    RunPageLink = "Account No" = field("No.");
                }
            }
        }
        area(processing)
        {
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    //TESTFIELD("Employer Code");
                    TestField("Account Type");
                    //TESTFIELD("ID No.");
                    TestField("Staff No");
                    //TESTFIELD("BOSA Account No");
                    TestField("Date of Birth");
                    TestField("Global Dimension 2 Code");



                    if "Application Status" = "application status"::Converted then
                        Error('Application has already been Created.');

                    //-----Check Nominee details----------------
                    if ("Account Type" = 'SAVINGS') then begin
                        Nok.Reset;
                        Nok.SetRange(Nok."Account No", "No.");
                        if Nok.Find('-') = false then begin
                            Error('Next of Kin have not been specified.');
                        end;
                    end;
                    //-----Check Nominee details----------------



                    if Confirm('Are you sure you want to approve & create this account', true) = false then
                        exit;
                    "Application Status" := "application status"::Converted;
                    Modify;

                    BranchC := '';
                    IncrementNo := '';
                    /*
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(DimensionValue.Code,"Global Dimension 2 Code");
                    IF DimensionValue.FIND('-') THEN
                    BranchC:=DimensionValue."Account Code";
                    IncrementNo:=INCSTR(DimensionValue."No. Series");
                    
                    DimensionValue."No. Series":=IncrementNo;
                    DimensionValue.MODIFY;
                    */

                    if AccoutTypes.Get("Account Type") then begin
                        if AccoutTypes."Fixed Deposit" = true then begin
                            TestField("Savings Account No.");
                            //TESTFIELD("Maturity Type");
                            //TESTFIELD("Fixed Deposit Type");
                        end;

                        //Based on BOSA
                        ///////
                        if "Parent Account No." = '' then begin
                            if DimensionValue.Get('BRANCH', "Global Dimension 2 Code") then begin

                                if (AccoutTypes."Use Savings Account Number" = true) then begin
                                    TestField("Savings Account No.");
                                    AcctNo := AccoutTypes."Account No Prefix" + CopyStr("Savings Account No.", 4)
                                end else
                                    //DimensionValue."No. Series":=INCSTR(DimensionValue."No. Series");
                                    DimensionValue.Modify;
                            end;

                        end else begin
                            TestField("Kin No");
                            AcctNo := CopyStr("Parent Account No.", 1, 14) + "Kin No";
                        end;
                        if AccoutTypes."Fixed Deposit" = true then begin
                            if "Kin No" <> '' then
                                AcctNo := CopyStr(AcctNo, 1, 14) + "Kin No";
                        end;
                        ///////
                        AccoutTypes.Get("Account Type");
                        if AccoutTypes.Code = 'Salary' then begin
                            //IF  "Kin No" <>'' THEN
                            AcctNo := AccoutTypes."Account No Prefix" + '-' + AccoutTypes."Ending Series";


                            Accounts.Init;
                            //Accounts."No.":=AcctNo;
                            Accounts."No." := "No.";
                            AcctNo := "No.";
                            Accounts."Date of Birth" := "Date of Birth";
                            Accounts.Name := Name;
                            Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                            Accounts."Debtor Type" := "Debtor Type";
                            if "Micro Single" = true then
                                Accounts."Group Account" := false
                            else
                                if "Micro Group" = true then
                                    Accounts."Group Account" := false;
                            Accounts."Personal No." := "Staff No";
                            Accounts."ID No." := "ID No.";
                            Accounts."Mobile Phone No" := "Mobile Phone No";
                            Accounts."Registration Date" := "Registration Date";
                            Accounts."Marital Status" := "Marital Status";
                            Accounts."BOSA Account No" := "BOSA Account No";
                            // Accounts.Picture := Picture;
                            Accounts.Signature := Signature;
                            Accounts."Passport No." := "Passport No.";
                            Accounts."Employer Code" := "Employer Code";
                            Accounts.Status := Accounts.Status::Active;
                            Accounts."Account Type" := "Account Type";
                            Accounts."Account Category" := "Account Category";
                            Accounts."Date of Birth" := "Date of Birth";
                            Accounts."Global Dimension 1 Code" := 'FOSA';
                            Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Accounts.Address := Address;
                            Accounts."Address 2" := "Address 2";
                            Accounts.City := City;
                            Accounts."Phone No." := "Phone No.";
                            Accounts."Telex No." := "Telex No.";
                            Accounts."Post Code" := "Post Code";
                            Accounts.County := County;
                            Accounts."E-Mail" := "E-Mail";
                            Accounts."Home Page" := "Home Page";
                            Accounts."Registration Date" := Today;
                            //Accounts.Status:=Status::New;
                            //Accounts.Status:=Status::Open;
                            Accounts.Section := Section;
                            Accounts."Home Address" := "Home Address";
                            Accounts.District := District;
                            Accounts.Location := Location;
                            Accounts."Sub-Location" := "Sub-Location";
                            Accounts."Savings Account No." := "Savings Account No.";
                            Accounts."Signing Instructions" := "Signing Instructions";
                            Accounts."Fixed Deposit Type" := "Fixed Deposit Type";
                            Accounts."FD Maturity Date" := "FD Maturity Date";
                            Accounts."Registration Date" := Today;
                            Accounts."Monthly Contribution" := "Monthly Contribution";
                            Accounts."Formation/Province" := "Formation/Province";
                            Accounts."Division/Department" := "Division/Department";
                            Accounts."Station/Sections" := "Station/Sections";
                            Accounts."Force No." := "Force No.";
                            Accounts."Vendor Posting Group" := "Account Type";
                            Accounts.Insert;

                        end;

                    end;
                    Accounts.Reset;
                    if Accounts.Get(AcctNo) then begin
                        Accounts.Validate(Accounts.Name);
                        Accounts.Validate(Accounts."Account Type");
                        Accounts.Validate(Accounts."Global Dimension 1 Code");
                        Accounts.Validate(Accounts."Global Dimension 2 Code");
                        Accounts.Modify;

                        //Update BOSA with FOSA Account
                        if ("Account Type" = 'SAV') then begin
                            if Cust.Get("BOSA Account No") then begin
                                Cust."FOSA Account No." := AcctNo;
                                //Cust."FOSA Account":="No.";
                                Cust.Modify;
                            end;
                        end;

                    end;

                    NextOfKinApp.Reset;
                    NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                    if NextOfKinApp.Find('-') then begin
                        repeat
                            NextOfKin.Init;
                            //NextOfKin."Account No":=AcctNo;
                            NextOfKin."Account No" := "No.";

                            NextOfKin.Name := NextOfKinApp.Name;
                            NextOfKin.Relationship := NextOfKinApp.Relationship;
                            NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                            NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                            NextOfKin.Address := NextOfKinApp.Address;
                            NextOfKin.Telephone := NextOfKinApp.Telephone;
                            NextOfKin.Fax := NextOfKinApp.Fax;
                            NextOfKin.Email := NextOfKinApp.Email;
                            NextOfKin."ID No." := NextOfKinApp."ID No.";
                            NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                            NextOfKin.Insert;

                        until NextOfKinApp.Next = 0;
                    end;

                    AccountSignApp.Reset;
                    AccountSignApp.SetRange(AccountSignApp."Document No", "No.");
                    if AccountSignApp.Find('-') then begin
                        repeat
                            AccountSign.Init;
                            AccountSign."Account No" := AcctNo;
                            AccountSign.Names := AccountSignApp.Names;
                            AccountSign."Date Of Birth" := "Date of Birth";
                            AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                            AccountSign."ID No." := AccountSignApp."ID No.";
                            AccountSign.Signatory := AccountSignApp.Signatory;
                            AccountSign."Must Sign" := AccountSignApp."Must Sign";
                            AccountSign."Must be Present" := AccountSignApp."Must be Present";
                            AccountSign.Picture := AccountSignApp.Picture;
                            AccountSign.Signature := AccountSignApp.Signature;
                            AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                            AccountSign.Insert;

                        until AccountSignApp.Next = 0;
                    end;

                    Message('Account approved & created successfully.');

                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if "Application Status" = "application status"::Converted then
                        Error('Application has already been converted.');

                    if Confirm('Are you sure you want to reject this application', true) = true then begin
                        "Application Status" := "application status"::Rejected;
                        Modify;
                    end;
                end;
            }
            group(Approvals)
            {
                action(Create)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Product';
                    Enabled = EnableCreateMember;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        ObjAccounttypes: Record "Account Types-Saving Products";
                        VarMaxnoofAccounts: Integer;
                        ObjAccounts: Record Vendor;
                        VarNoofMemberAccounts: Integer;
                    begin

                        //-----Check Mandatory Fields---------
                        //TESTFIELD("Employer Code");
                        TestField("Account Type");
                        TestField("ID No.");
                        //TESTFIELD("Staff No");
                        TestField("BOSA Account No");
                        TestField("Date of Birth");
                        TestField("Global Dimension 2 Code");
                        if "Global Dimension 2 Code" = '' then
                            Error('Please specify the branch.');

                        //-----End Check Mandatory Fields---------

                        VarNoofMemberAccounts := 0;

                        ObjAccounttypes.Reset;
                        ObjAccounttypes.SetRange(ObjAccounttypes.Code, "Account Type");
                        if ObjAccounttypes.FindSet then begin
                            VarMaxnoofAccounts := ObjAccounttypes."Maximum No Of Accounts";

                            ObjAccounts.Reset;
                            ObjAccounts.SetRange(ObjAccounts."ID No.", "ID No.");
                            ObjAccounts.SetRange(ObjAccounts."Account Type", "Account Type");
                            if ObjAccounts.FindSet then begin
                                VarNoofMemberAccounts := ObjAccounts.Count;
                            end;

                            if VarNoofMemberAccounts >= VarMaxnoofAccounts then begin
                                Error('Member has exceeded the maximum no of accounts one can have for this product.No of accounts the Member has %1#,maximum allowable %2#', VarNoofMemberAccounts, VarMaxnoofAccounts);
                            end;
                        end;


                        /*//----Check If account Already Exists------
                        Acc.RESET;
                        Acc.SETRANGE(Acc."ID No.","ID No.");
                        Acc.SETRANGE(Acc."Account Type","Account Type");
                        Acc.SETRANGE(Acc.Status,Acc.Status::Active);
                          IF Acc.FIND('-') THEN
                            ERROR('Account already exists. %1',Acc."No.");
                        //----End Check If account Already Exists------*/


                        //---Checkfields If Fixed Deposit------------
                        if AccoutTypes.Get("Account Type") then begin
                            if AccoutTypes."Fixed Deposit" = true then begin
                                TestField("Savings Account No.");
                                //TESTFIELD("Maturity Type");
                                //TESTFIELD("Fixed Deposit Type");
                            end;
                            //---End Checkfields If Fixed Deposit------------

                            if "Application Status" = "application status"::Converted then
                                Error('Application has already been converted.');



                            if Confirm('Are you sure you want to create this account?', true) = false then
                                exit;
                            "Application Status" := "application status"::Converted;
                            "Registration Date" := Today;
                            Modify;

                            ObjMemberNoseries.Reset;
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", "Account Type");
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                            if ObjMemberNoseries.FindSet then begin
                                VarAcctNo := ObjMemberNoseries."Account No";
                            end;

                            /*IF ObjAccounttypes.GET("Account Type") THEN
                              BEGIN
                                VarMaxNoOfAccountsAllowable:=ObjAccounttypes."Maximum No Of Accounts";
                                END;
                        
                            ObjAccounts.RESET;
                            ObjAccounts.SETRANGE(ObjAccounts."ID No.","ID No.");
                            ObjAccounts.SETRANGE(ObjAccounts."Account Type","Account Type");
                            IF ObjAccounts.FINDSET THEN BEGIN
                              VarNoAccounts:=ObjAccounts.COUNT;
                              IF VarNoAccounts>=VarMaxNoOfAccountsAllowable THEN
                              ERROR('The Member has Exceeeded the Maximum no of Accounts they can have under this product, Account Type %1 , No of Accounts %2',
                              "Account Type",VarNoAccounts);
                              END;*/
                            AcctNo := VarAcctNo;


                            //---Create Account on Vendor Table----
                            Accounts.Init;
                            Accounts."No." := AcctNo;
                            Accounts."Date of Birth" := "Date of Birth";
                            Accounts.Name := Name;
                            Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                            Accounts."Personal No." := "Staff No";
                            Accounts."ID No." := "ID No.";
                            Accounts."Mobile Phone No" := "Mobile Phone No";
                            Accounts."Registration Date" := "Registration Date";
                            Accounts."Employer Code" := "Employer Code";
                            Accounts."BOSA Account No" := "BOSA Account No";
                            //Accounts.Picture := Picture;
                            Accounts.Signature := Signature;
                            Accounts."Passport No." := "Passport No.";
                            Accounts.Status := Accounts.Status::Active;
                            Accounts."Account Type" := "Account Type";
                            Accounts."Account Category" := "Account Category";
                            Accounts."Date of Birth" := "Date of Birth";
                            Accounts."Global Dimension 1 Code" := 'FOSA';
                            Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Accounts.Address := Address;
                            Accounts."Address 2" := "Address 2";
                            Accounts.City := City;
                            Accounts."Phone No." := "Phone No.";
                            Accounts."Telex No." := "Telex No.";
                            Accounts."Post Code" := "Post Code";
                            Accounts.County := County;
                            Accounts."E-Mail" := "E-Mail";
                            Accounts."Home Page" := "Home Page";
                            Accounts."Registration Date" := Today;
                            Accounts.Status := Status::Approved;
                            Accounts.Section := Section;
                            Accounts."Home Address" := "Home Address";
                            Accounts.District := District;
                            Accounts.Location := Location;
                            Accounts."Sub-Location" := "Sub-Location";
                            Accounts."Savings Account No." := "Savings Account No.";
                            Accounts."Registration Date" := Today;
                            Accounts."Vendor Posting Group" := "Vendor Posting Group";
                            Accounts.Insert;
                            "Application Status" := "application status"::Converted;
                        end;
                        //AccoutTypes."Last No Used":=INCSTR(AccoutTypes."Last No Used");

                        ObjMemberNoseries.Reset;
                        ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", "Account Type");
                        ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                        if ObjMemberNoseries.FindSet then begin
                            ObjMemberNoseries."Account No" := IncStr(AcctNo);
                            ObjMemberNoseries.Modify;
                        end;


                        Accounts.Reset;
                        if Accounts.Get(AcctNo) then begin
                            Accounts.Validate(Accounts.Name);
                            Accounts.Validate(Accounts."Account Type");
                            Accounts.Validate(Accounts."Global Dimension 1 Code");
                            Accounts.Validate(Accounts."Global Dimension 2 Code");
                            Accounts.Modify;

                            //---Update BOSA with FOSA Account----
                            if ("Account Type" = 'SAVINGS') then begin
                                if Cust.Get("BOSA Account No") then begin
                                    Cust."FOSA Account No." := AcctNo;
                                    Cust.Modify;
                                end;
                            end;
                            //---End Update BOSA with FOSA Account----
                        end;

                        //----Insert Nominee Information------
                        NextOfKinApp.Reset;
                        NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                        if NextOfKinApp.Find('-') then begin
                            repeat
                                NextOfKin.Init;
                                NextOfKin."Account No" := AcctNo;
                                NextOfKin.Name := NextOfKinApp.Name;
                                NextOfKin.Relationship := NextOfKinApp.Relationship;
                                NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                                NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                                NextOfKin.Address := NextOfKinApp.Address;
                                NextOfKin.Telephone := NextOfKinApp.Telephone;
                                //NextOfKin.Fax:=NextOfKinApp.Fax;
                                NextOfKin.Email := NextOfKinApp.Email;
                                NextOfKin."ID No." := NextOfKinApp."ID No.";
                                NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                                NextOfKin.Insert;
                            until NextOfKinApp.Next = 0;
                        end;
                        //----End Insert Nominee Information------

                        //Insert Account Signatories------
                        AccountSignApp.Reset;
                        AccountSignApp.SetRange(AccountSignApp."Document No", "No.");
                        if AccountSignApp.Find('-') then begin
                            repeat
                                AccountSign.Init;
                                AccountSign."Account No" := AcctNo;
                                AccountSign.Names := AccountSignApp.Names;
                                AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                                AccountSign."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                AccountSign."ID No." := AccountSignApp."ID No.";
                                AccountSign.Signatory := AccountSignApp.Signatory;
                                AccountSign."Must Sign" := AccountSignApp."Must Sign";
                                AccountSign."Must be Present" := AccountSignApp."Must be Present";
                                //AccountSign.Picture:=AccountSignApp.Picture;
                                //AccountSign.Signature:=AccountSignApp.Signature;
                                AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                AccountSign.Insert;
                                "Application Status" := "application status"::Converted;
                            until AccountSignApp.Next = 0;
                        end;
                        //Insert Account Signatories------

                        //Insert Account Agents------
                        ObjAccountAppAgents.Reset;
                        ObjAccountAppAgents.SetRange(ObjAccountAppAgents."Account No", "No.");
                        if ObjAccountAppAgents.Find('-') then begin
                            repeat
                                ObjAccountAgents.Init;
                                ObjAccountAgents."Account No" := AcctNo;
                                ObjAccountAgents.Names := ObjAccountAppAgents.Names;
                                ObjAccountAgents."Date Of Birth" := ObjAccountAppAgents."Date Of Birth";
                                ObjAccountAgents."Staff/Payroll" := ObjAccountAppAgents."Staff/Payroll";
                                ObjAccountAgents."ID No." := ObjAccountAppAgents."ID No.";
                                ObjAccountAgents."Allowed  Correspondence" := ObjAccountAppAgents."Allowed  Correspondence";
                                ObjAccountAgents."Allowed Balance Enquiry" := ObjAccountAppAgents."Allowed Balance Enquiry";
                                ObjAccountAgents."Allowed FOSA Withdrawals" := ObjAccountAppAgents."Allowed FOSA Withdrawals";
                                ObjAccountAgents."Allowed Loan Processing" := ObjAccountAppAgents."Allowed Loan Processing";
                                ObjAccountAgents."Must Sign" := ObjAccountAppAgents."Must Sign";
                                ObjAccountAgents."Must be Present" := ObjAccountAppAgents."Must be Present";
                                ObjAccountAgents.Picture := ObjAccountAppAgents.Picture;
                                ObjAccountAgents.Signature := ObjAccountAppAgents.Signature;
                                ObjAccountAgents."Expiry Date" := ObjAccountAppAgents."Expiry Date";
                                ObjAccountAgents.Insert;
                                "Application Status" := "application status"::Converted;
                            until ObjAccountAppAgents.Next = 0;
                        end;
                        //Insert Account Agents------

                        //--Send Confirmation Sms to The Member------
                        SFactory.FnSendSMS('FOSA ACC', 'Your Account successfully created.Account No=' + AcctNo, AcctNo, "Mobile Phone No");
                        Message('You have successfully created a %1 Product, A/C No=%2. Member will be notified via SMS', "Account Type", AcctNo);


                        ObjMember.Reset;
                        ObjMember.SetRange(ObjMember."No.", "BOSA Account No");
                        if ObjMember.FindSet then begin
                            if "Account Type" = '602' then begin
                                ObjMember."Deposits Account No" := AcctNo;
                                ObjMember.Modify;
                            end;

                            if "Account Type" = '601' then begin
                                ObjMember."Share Capital No" := AcctNo;
                                ObjMember.Modify;
                            end;

                            if "Account Type" = '605' then begin
                                ObjMember."FOSA Shares Account No" := AcctNo;
                                ObjMember.Modify;
                            end;

                            if "Account Type" = '606' then begin
                                ObjMember."Benevolent Fund No" := AcctNo;
                                ObjMember.Modify;
                            end;
                        end;



                        if ObjAccounts.Get(AcctNo) then begin
                            ObjAccounts.Status := ObjAccounts.Status::Active;
                            ObjAccounts.Modify;
                        end;

                        CurrPage.Close;

                    end;
                }
                action(CreateII)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Enabled = EnableCreateMember;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ObjAccountTypes: Record "Account Types-Saving Products";
                    begin
                        //==================================================================================================Front Office Accounts
                        if Confirm('Are you sure you want to create this account?', true) = false then
                            exit;

                        // ObjMemberNoseries.Reset;
                        // ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", "Account Type");
                        // ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                        // if ObjMemberNoseries.FindSet then begin
                        //     VarAcctNo := ObjMemberNoseries."Account No";
                        // end;
                        ObjAccountTypes.Reset();
                        ;
                        ObjAccountTypes.SetRange(ObjAccountTypes.code, "Account Type");
                        if ObjAccountTypes.Find('-') then begin
                            VarAcctNo := ObjAccountTypes."Account No Prefix" + '-' + "BOSA Account No" + '-' + IncStr(ObjAccountTypes."Last No Used");
                        end;
                        Message('Generated account number is %1', VarAcctNo);
                        ObjAccountTypes.Reset;
                        ObjAccountTypes.SetRange(ObjAccountTypes.Code, "Account Type");
                        if ObjAccountTypes.FindSet then begin
                            VarMaxNoOfAccountsAllowable := ObjAccountTypes."Maximum No Of Accounts";
                        end;

                        ObjAccounts.Reset;
                        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", "BOSA Account No");
                        ObjAccounts.SetRange(ObjAccounts."Account Type", "Account Type");
                        ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1&<>%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                        if ObjAccounts.FindSet then begin
                            VarNoAccounts := ObjAccounts.Count;
                            if VarNoAccounts >= VarMaxNoOfAccountsAllowable then
                                Error('The Member has Exceeeded the Maximum No of Accounts they can have under this product. No. of Accounts %1 , Maximum No. of Accounts %2',
                                VarNoAccounts, VarMaxNoOfAccountsAllowable);
                        end;

                        //===================================================================Create FOSA account
                        ObjAccounts.Init;
                        ObjAccounts."No." := VarAcctNo;
                        ObjAccounts."Date of Birth" := "Date of Birth";
                        ObjAccounts.Name := Name;
                        ObjAccounts."Creditor Type" := ObjAccounts."creditor type"::"FOSA Account";
                        ObjAccounts."Personal No." := "Staff No";
                        ObjAccounts."ID No." := "ID No.";
                        ObjAccounts."Mobile Phone No" := "Mobile Phone No";
                        ObjAccounts."Phone No." := "Mobile Phone No";
                        ObjAccounts."Registration Date" := "Registration Date";
                        ObjAccounts."Post Code" := "Post Code";
                        ObjAccounts.County := City;
                        ObjAccounts."BOSA Account No" := "BOSA Account No";
                        ObjAccounts.Piccture := Picture;
                        ObjAccounts.Signature := Signature;
                        ObjAccounts."Passport No." := "Passport No.";
                        ObjAccounts."Employer Code" := "Employer Code";
                        ObjAccounts.Status := ObjAccounts.Status::Deceased;
                        ObjAccounts."Account Type" := "Account Type";
                        ObjAccounts."Date of Birth" := "Date of Birth";
                        ObjAccounts."Global Dimension 1 Code" := "Global Dimension 1 Code";
                        ObjAccounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                        ObjAccounts.Address := Address;
                        if "Account Category" = "account category"::Corporate then begin
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
                        //ObjAccounts."Group/Corporate Trade":="Group/Corporate Trade";
                        ObjAccounts."Name of the Group/Corporate" := "Name of the Group/Corporate";
                        ObjAccounts."Certificate No" := "Certificate No";
                        ObjAccounts."Registration Date" := "Registration Date";
                        ObjAccounts."Created By" := UserId;
                        ObjAccounts."Account Creation Date" := WorkDate;

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
                        //IF "Account Category"="Account Category"::Joint THEN
                        //ObjAccounts."Joint Account Name":="First Name"+' '+"First Name2";


                        ObjAccounts."Name 3" := "Name 3";
                        ObjAccounts."Address3-Joint" := Address4;
                        ObjAccounts."Postal Code 3" := "Postal Code 3";
                        ObjAccounts."ID No.3" := "ID No.3";
                        ObjAccounts."Passport 3" := "Passport 3";
                        ObjAccounts.Gender3 := Gender3;
                        ObjAccounts."Marital Status3" := "Marital Status3";
                        ObjAccounts."E-Mail (Personal3)" := "E-Mail (Personal3)";
                        ObjAccounts."Employer Code3" := "Employer Code3";
                        ObjAccounts."Employer Name3" := "Employer Name3";
                        ObjAccounts."Picture 3" := "Picture 3";
                        ObjAccounts."Signature  3" := "Signature  3";
                        //IF "Account Category"="Account Category"::Joint THEN
                        //ObjAccounts."Joint Account Name":="First Name"+' &'+"First Name2"+' &'+"First Name3"+'JA';

                        //=============================================================End Joint Account Details
                        ObjAccounts.Insert(true);
                        if ObjAccounts.Insert(true) then begin
                            ObjAccountTypes.Reset();
                            ObjAccountTypes.SetRange(ObjAccountTypes.code, "Account Type");
                            if ObjAccountTypes.Find('-') then begin
                                ObjAccountTypes."Last No Used" := IncStr(ObjAccountTypes."Last No Used");
                            end;
                        end;


                        ObjAccounts.Reset;
                        if ObjAccounts.Get(VarAcctNo) then begin
                            ObjAccounts.Validate(ObjAccounts.Name);
                            ObjAccounts.Validate(ObjAccounts."Account Type");
                            ObjAccounts.Modify;


                            ObjMemberNoseries.Reset;
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", "Account Type");
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", "Global Dimension 2 Code");
                            if ObjMemberNoseries.FindSet then begin
                                ObjMemberNoseries."Account No" := IncStr(ObjMemberNoseries."Account No");
                                ObjMemberNoseries.Modify;
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
                                            ObjAccountSign."Email Address" := ObjAccountSignApp."Email Address";
                                            ObjAccountSign."Mobile No" := ObjAccountSignApp."Mobile Phone No.";
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
                        end;
                        Message('You have successfully created a %1 Product, A/C No=%2', "Account Type", VarAcctNo);

                        //==========================================================================================================End Front Office Accounts
                        if Confirm('Do you want to notify this member through sms?') then begin
                            SFactory.FnSendSMS('ACCOUNTAPP', 'Dear ' + Name + 'Your ' + "Account Type" + 'has been created. Your account number is ' +
                            VarAcctNo, "BOSA Account No", "Phone No.");
                        end;

                        //========================================================================================================Update Piggy Bank Details
                        if (ObjNoSeries.Get) and ("Issue Piggy Bank" = true) then begin
                            SFactory.FnRunPostPiggyBankCharges("No.", false);

                            ObjNoSeries.TestField(ObjNoSeries."Piggy Bank No");
                            VarPiggyBankNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Piggy Bank No", 0D, true);
                            if VarPiggyBankNo <> '' then begin
                                ObjPiggyBank.Init;
                                ObjPiggyBank."Document No" := VarPiggyBankNo;
                                ObjPiggyBank."Member Account No" := "BOSA Account No";
                                ObjPiggyBank."Member Name" := "Parent Account Name";
                                ObjPiggyBank."Piggy Bank Account" := VarAcctNo;
                                ObjPiggyBank."Piggy Bank Account Name" := Name;
                                ObjPiggyBank."Issued On" := WorkDate;
                                ObjPiggyBank."Issued By" := UserId;
                                ObjPiggyBank."Collected By" := "Parent Account Name";
                                ObjPiggyBank.Insert;
                            end;
                        end;
                        CurrPage.Close();
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowMgt: Codeunit WorkflowIntegration;
                    begin
                        if Confirm('Are you sure you want to send Approval request for this record?', true) = false then
                            exit;
                        if "Micro Group" <> true then begin
                            TestField("Account Type");
                            TestField("ID No.");
                            TestField("BOSA Account No");
                            TestField("Date of Birth");
                            TestField("Global Dimension 2 Code");
                        end;

                        if WorkflowMgt.CheckFAccountApplicationApprovalsWorkflowEnabled(Rec) then
                            WorkflowMgt.OnSendFAccountApplicationForApproval(Rec);
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
                        WorkflowMgt: Codeunit WorkflowIntegration;
                    begin
                        if Confirm('Are you sure you want cancel Approval request for this record?', true) = false then
                            exit;
                        WorkflowMgt.OnCancelFAccountApplicationApprovalRequest(Rec);
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
                        DocumentType := Documenttype::ProductApplication;
                        ApprovalEntries.Setfilters(Database::"FOSA Account Applicat. Details", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
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
    end;

    trigger OnAfterGetRecord()
    begin
        //UpdateControls;



        EmployerCodeEditable := true;
        DepartmentEditable := true;
        TermsofEmploymentEditable := true;
        ContractingEditable := true;
        EmployedEditable := true;
        OccupationEditable := true;
        PositionHeldEditable := true;
        EmploymentDateEditable := true;
        EmployerAddressEditable := true;
        NatureofBussEditable := true;
        IndustryEditable := true;
        BusinessNameEditable := true;
        PhysicalBussLocationEditable := true;
        YearOfCommenceEditable := true;
        if "Employment Info" = "employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if "Employment Info" = "employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if "Employment Info" = "employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if "Employment Info" = "employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Find(Which);
        CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //"Debtor Type":="Debtor Type"::Account;
        //"Application Date":=TODAY;
        "Global Dimension 1 Code" := 'FOSA';
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin

        ActivateFields;

        if Status = Status::Approved then
            CurrPage.Editable := false;
        UpdateControls;


        EmploymentInfoEditable := true;
        EmployerCodeEditable := true;
        DepartmentEditable := true;
        TermsofEmploymentEditable := true;
        ContractingEditable := true;
        EmployedEditable := true;
        OccupationEditable := true;
        PositionHeldEditable := true;
        EmploymentDateEditable := true;
        EmployerAddressEditable := true;
        NatureofBussEditable := true;
        IndustryEditable := true;
        BusinessNameEditable := true;
        PhysicalBussLocationEditable := true;
        YearOfCommenceEditable := true;




        if "Employment Info" = "employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if "Employment Info" = "employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if "Employment Info" = "employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if "Employment Info" = "employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        PictureExists: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        Accounts: Record Vendor;
        AcctNo: Code[50];
        DimensionValue: Record "Dimension Value";
        NextOfKin: Record "FOSA Account NOK Details";
        NextOfKinApp: Record "FOSA Account App Kin Details";
        AccountSign: Record "FOSA Account Sign. Details";
        AccountSignApp: Record "Product App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "FOSA Account App Kin Details";
        Cust: Record Customer;
        NOKBOSA: Record "FOSA Account NOK Details";
        BranchC: Code[20];
        DimensionV: Record "Dimension Value";
        IncrementNo: Code[20];
        MicSingle: Boolean;
        MicGroup: Boolean;
        BosaAcnt: Boolean;
        EmailEdiatble: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions;
        SaccoSetup: Record "Sacco No. Series";
        MicroGroupCode: Boolean;
        Vendor: Record Vendor;
        NameEditable: Boolean;
        NoEditable: Boolean;
        AddressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        DocNo: code[40];
        VendorPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        Accountypessetup: Record "Account Types-Saving Products";
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        BOSAnoEditable: Boolean;
        MobileNoEditable: Boolean;
        PassPortNoEditable: Boolean;
        ApplicationDateEditable: Boolean;
        AccountTypeEditable: Boolean;
        AccountCategoryEditable: Boolean;
        ParentAccountEditable: Boolean;
        SavingsAccountEditable: Boolean;
        SigningInstructionEditable: Boolean;
        ActivityEditable: Boolean;
        BranchEditable: Boolean;
        Accountype: Boolean;
        Approvalusers: Record "Status Change Permision";
        Member: Record Customer;
        IncrementNoF: Code[20];
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ParentEditable: Boolean;
        SavingsEditable: Boolean;
        CurrentAcc: Code[20];
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        ObjAccountAgents: Record "Account Agent Details";
        ObjAccountAppAgents: Record "Account Agents App Details";
        EmploymentInfoEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        ContractingEditable: Boolean;
        EmployedEditable: Boolean;
        OccupationEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        OthersEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        RefereeEditable: Boolean;
        ObjMember: Record Customer;
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarAcctNo: Code[30];
        VarMaxNoOfAccountsAllowable: Integer;
        VarNoAccounts: Integer;
        ObjAccountSign: Record "FOSA Account Sign. Details";
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjAccounts: Record Vendor;
        ObjNextOfKinApp: Record "FOSA Account App Kin Details";
        ObjMemberAppAgent: Record "Account Agents App Details";
        ObjAccountSignApp: Record "Product App Signatories";
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ObjPiggyBank: Record "Piggy Bank Issuance";
        VarPiggyBankNo: Code[30];


    procedure ActivateFields()
    begin
    end;

    local procedure ContactOnAfterValidate()
    begin
        ActivateFields;
    end;

    local procedure ICPartnerCodeOnAfterValidate()
    begin
        CurrPage.Update;
    end;


    procedure Controls()
    begin
        //IF (MicSingle = TRUE) OR (MicGroup=TRUE) THEN
        //BosaAcnt:=FALSE

        if "Micro Single" = true then
            MicroGroupCode := true;
    end;


    procedure UpdateControls()
    begin

        if Status = Status::Approved then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            ActivityEditable := false;
            BranchEditable := false;
            SigningInstructionEditable := false;
            BOSAnoEditable := false;
            SavingsAccountEditable := false;
            ParentAccountEditable := false;
            MobileNoEditable := false;
            AccountTypeEditable := false;
            VendorPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            PassPortNoEditable := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            ContactPPhoneEditable := false;
        end;


        if Status = Status::Pending then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            ActivityEditable := false;
            BranchEditable := false;
            SigningInstructionEditable := false;
            BOSAnoEditable := false;
            SavingsAccountEditable := false;
            ParentAccountEditable := false;
            MobileNoEditable := false;
            AccountTypeEditable := false;
            VendorPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            PassPortNoEditable := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            ContactPPhoneEditable := false;
        end;

        if Status = Status::Open then begin
            NameEditable := true;
            NoEditable := true;
            AddressEditable := true;
            ActivityEditable := true;
            BranchEditable := true;
            SigningInstructionEditable := true;
            BOSAnoEditable := true;
            SavingsAccountEditable := true;
            ParentAccountEditable := true;
            MobileNoEditable := true;
            AccountTypeEditable := true;
            VendorPostingGroupEdit := true;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            PassPortNoEditable := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            ContactPPhoneEditable := true;
        end;
    end;
}

