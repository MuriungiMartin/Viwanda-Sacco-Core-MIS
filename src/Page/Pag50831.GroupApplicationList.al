#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50831 "Group Application List"
{
    CardPageID = "Group Application Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("Search Name"; "Search Name")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Centre"; "Responsibility Centre")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Category; Category)
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; "Account Category")
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
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
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
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Mobile Membership Appl Card";
                    RunPageLink = MobileNo = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;

                    PromotedCategory = Process;
                    // RunObject = Page "Product App Signatories";
                    // RunPageLink = "Document No"=field("No.");
                }
                separator(Action1102755012)
                {
                    Caption = '-';
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /*DocumentType:=DocumentType::"Account Opening";
                        ApprovalEntries.Setfilters(DATABASE::"Member Application",DocumentType,"No.");
                        ApprovalEntries.RUN;*/

                    end;
                }
                separator(Action1102755004)
                {
                    Caption = '       -';
                }
                action("Create Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');


                        if Confirm('Are you sure you want to create account application?', false) = true then begin

                            if "ID No." <> '' then begin
                                Cust.Reset;
                                Cust.SetRange(Cust."ID No.", "ID No.");
                                Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                if Cust.Find('-') then begin
                                    if Cust."No." <> "No." then
                                        Error('Member has already been created');
                                end;
                            end;

                            //Create BOSA account
                            Cust."No." := '';
                            Cust.Name := UpperCase(Name);
                            Cust.Address := Address;
                            Cust."Post Code" := "Postal Code";
                            Cust.City := City;
                            Cust.County := City;
                            Cust."Country/Region Code" := "Country/Region Code";
                            Cust."Phone No." := "Phone No.";
                            Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                            Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                            Cust."Customer Posting Group" := "Customer Posting Group";
                            Cust."Registration Date" := Today;//"Registration Date"; Registration date must be the day the application is converted to a member and not day of capture*****cyrus
                            Cust.Status := Cust.Status::Active;
                            Cust."Employer Code" := "Employer Code";
                            Cust."Date of Birth" := "Date of Birth";
                            Cust."Station/Department" := "Station/Department";
                            Cust."E-Mail" := "E-Mail (Personal)";
                            Cust.Location := Location;
                            //**
                            Cust."Office Branch" := "Office Branch";
                            Cust.Department := Department;
                            Cust.Occupation := Format(Occupation);
                            Cust.Designation := Designation;
                            Cust."Bank Code" := "Bank Code";
                            //Cust."Bank Branch Code":="Bank Name";
                            Cust."Bank Account No." := "Bank Account No";
                            //**
                            Cust."Sub-Location" := "Sub-Location";
                            Cust.District := District;
                            //Cust.Pin:="Payroll/Staff No";
                            Cust."ID No." := "ID No.";
                            Cust."Passport No." := "Passport No.";
                            //Cust."Business Loan Officer":="Salesperson Code";
                            Cust."Mobile Phone No" := "Mobile Phone No";
                            Cust."Marital Status" := "Marital Status";
                            Cust."Customer Type" := Cust."customer type"::Member;
                            Cust.Gender := Gender;

                            //CALCFIELDS(Signature,Picture);

                            Cust."Monthly Contribution" := "Monthly Contribution";
                            Cust."Contact Person" := "Contact Person";
                            Cust."Contact Person Phone" := "Contact Person Phone";
                            Cust."ContactPerson Relation" := "ContactPerson Relation";
                            Cust."Recruited By" := "Recruited By";
                            //Cust."Business Loan Officer":="Salesperson Code";
                            Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                            Cust."Village/Residence" := "Village/Residence";
                            Cust.Insert(true);
                            //Cust.VALIDATE(Cust."ID No.");

                            //CLEAR(Picture);
                            //CLEAR(Signature);
                            //MODIFY;


                            /*ImageData."ID NO":="ID No.";
                            ImageData.Picture:=Picture;
                            ImageData.Signature:=Signature;
                            ImageData.INSERT(TRUE);
                            */
                            BOSAACC := Cust."No.";

                            /*
                            AcctNo:='001208'+BOSAACC;
                            //Create FOSA account
                            Accounts.INIT;
                            Accounts."No.":=AcctNo;
                            Accounts."Date of Birth":="Date of Birth";
                            Accounts.Name:=Name;
                            Accounts."Creditor Type":=Accounts."Creditor Type"::Account;
                            Accounts."Staff No":="Payroll/Staff No";
                            Accounts."ID No.":="ID No.";
                            Accounts."Mobile Phone No":="Mobile Phone No";
                            Accounts."Registration Date":="Registration Date";
                            Accounts."Post Code":="Post Code";
                            Accounts.County:=City;
                            Accounts."BOSA Account No":=Cust."No.";
                            Accounts.Picture:=Picture;
                            Accounts.Signature:=Signature;
                            Accounts."Passport No.":="Passport No.";
                            Accounts."Company Code":="Employer Code";
                            Accounts.Status:=Accounts.Status::New;
                            Accounts."Account Type":='SAVINGS';
                            Accounts."Date of Birth":="Date of Birth";
                            Accounts."Global Dimension 1 Code":='FOSA';
                            Accounts."Global Dimension 2 Code":="Global Dimension 2 Code";
                            Accounts.Address:=Address;
                            Accounts."Address 2":="Address 2";
                            Accounts."Phone No.":="Phone No.";
                            Accounts."Registration Date":=TODAY;
                            Accounts.Status:=Accounts.Status::Active;
                            Accounts.Section:=Section;
                            Accounts."Home Address":="Home Address";
                            Accounts.District:=District;
                            Accounts.Location:=Location;
                            Accounts."Sub-Location":="Sub-Location";
                            Accounts."Registration Date":=TODAY;
                            Accounts."Monthly Contribution" := "Monthly Contribution";
                            Accounts."E-Mail":="E-Mail (Personal)";
                            //Accounts."Home Page":="Home Page";
                            //Accounts."Savings Account No.":="Savings Account No.";
                            //Accounts."Signing Instructions":="Signing Instructions";
                            //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                            //Accounts."FD Maturity Date":="FD Maturity Date";
                            //Accounts."Electrol Zone Code":="Electrol Zone Code";
                            //Accounts."Departments Code":="Departments Code";
                            //Accounts."Sections Code":="Sections Code";
                            Accounts.INSERT;


                            Accounts.RESET;
                            IF Accounts.GET(AcctNo) THEN BEGIN
                            Accounts.VALIDATE(Accounts.Name);
                            Accounts.VALIDATE(Accounts."Account Type");
                            Accounts.VALIDATE(Accounts."Global Dimension 1 Code");
                            Accounts.VALIDATE(Accounts."Global Dimension 2 Code");
                            Accounts.MODIFY;

                            //Update BOSA with FOSA Account
                            IF Cust.GET(BOSAACC) THEN BEGIN
                            Cust."FOSA Account":=AcctNo;
                            Cust.MODIFY;
                            END;
                            END;
                            */

                            NextOfKinApp.Reset;
                            NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                            if NextOfKinApp.Find('-') then begin
                                repeat
                                    NextOfKin.Init;
                                    NextOfKin."Account No" := BOSAACC;
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

                            AccountSignApp.Reset;
                            AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
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
                                    AccountSign.Picture := AccountSignApp.Picture;
                                    AccountSign.Signature := AccountSignApp.Signature;
                                    AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                    //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                    AccountSign.Insert;
                                until AccountSignApp.Next = 0;
                            end;

                            Cust.Reset;
                            if Cust.Get(BOSAACC) then begin
                                Cust.Validate(Cust.Name);
                                //Cust.VALIDATE(Accounts."Account Type");
                                Cust.Validate(Cust."Global Dimension 1 Code");
                                Cust.Validate(Cust."Global Dimension 2 Code");
                                Cust.Modify;
                            end;

                            /*
                            GenSetUp.GET();
                             Notification.CreateMessage('Dynamics NAV',GenSetUp."Sender Address","E-Mail (Personal)",'Member Acceptance Notification',
                                            'Member application '+ "No." + ' has been approved'
                                           + ' (Dynamics NAV ERP)',FALSE);
                             Notification.Send;
                            */

                            //"Converted By":=USERID;
                            Message('Account created successfully.');
                            //END;
                            Status := Status::Approved;
                            "Created By" := UserId;
                            Modify;


                            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Send SMS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


                            //ERROR('Sms Message');
                            //SMS MESSAGE
                            AccountSignatoriesApp.Reset;
                            AccountSignatoriesApp.SetRange(AccountSignatoriesApp."Document No", "No.");
                            if AccountSignatoriesApp.Find('-') then begin

                                AccountSignatoriesApp.Reset;
                                AccountSignatoriesApp.SetRange(AccountSignatoriesApp."Document No", "No.");
                                //AccountSignatoriesApp.SETRANGE(AccountSignatoriesApp."send sms",FALSE); //mutinda
                                if AccountSignatoriesApp.Find('-') then begin
                                    repeat

                                        //MESSAGE('Send sms to '+AccountSignatoriesApp."Account No");

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
                                        //SMSMessage."Account No":="Payroll/Staff No";
                                        SMSMessage."Date Entered" := Today;
                                        SMSMessage."Time Entered" := Time;
                                        SMSMessage.Source := 'MEMBERACCOUNT';
                                        SMSMessage."Entered By" := UserId;
                                        SMSMessage."System Created Entry" := true;
                                        SMSMessage."Document No" := "No.";
                                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                                        SMSMessage."SMS Message" := Name + ' has been succesfuly created. DEMO SACCCO';
                                        //SMSMessage."Telephone No":=AccountSignatories.mobile;
                                        SMSMessage.Insert;

                                        // AccountSignatoriesApp."Send SMS":=TRUE;
                                        AccountSignatoriesApp.Modify;

                                    until AccountSignatoriesApp.Next = 0;
                                end;
                            end;



                            //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                            // SEND SMS

                        end else
                            Error('Not approved');

                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        "Group Account" := true;
        "Account Category" := "account category"::Group;
        "Account Type" := "account type"::Group;
        Source := Source::Micro;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Nominee";
        NextofKinFOSA: Record "FOSA Account App Kin Details";
        AccountSign: Record "Member Account Signatories";
        AccountSignApp: Record "Member App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Nominee";
        NOKBOSA: Record "Members Next of Kin";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Next of Kin";
        PictureExists: Boolean;
        UserMgt: Codeunit "User Setup Management";
        NotificationE: Codeunit Mail;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        SignatureExists: Boolean;
        text002: label 'Kinldy specify the next of kin';
        AccountSignatoriesApp: Record "Product App Signatories";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
}

