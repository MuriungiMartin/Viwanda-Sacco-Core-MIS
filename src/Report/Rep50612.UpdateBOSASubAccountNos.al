
Report 50612 "Update BOSA Sub Account Nos"
{
    RDLCLayout = 'Layouts/UpdateBOSASubAccountNos.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("No." = filter('00003'));

            trigger OnAfterGetRecord();
            begin
                BOSAAcc.Reset;
                BOSAAcc.SetRange(BOSAAcc."Account Type", 'SHARECAP');
                BOSAAcc.SetRange(BOSAAcc."BOSA Account No", "No.");
                BOSAAcc.SetFilter(BOSAAcc.Status, '<>%1', BOSAAcc.Status::Closed);
                if BOSAAcc.FindSet then begin
                    "Share Capital No" := BOSAAcc."No.";
                    Modify;
                end;
                BOSAAcc.Reset;
                BOSAAcc.SetRange(BOSAAcc."Account Type", 'DEPOSITS');
                BOSAAcc.SetRange(BOSAAcc."BOSA Account No", "No.");
                BOSAAcc.SetFilter(BOSAAcc.Status, '<>%1', BOSAAcc.Status::Closed);
                if BOSAAcc.FindSet then begin
                    "Deposits Account No" := BOSAAcc."No.";
                    Modify;
                end;
                BOSAAcc.Reset;
                BOSAAcc.SetRange(BOSAAcc."Account Type", 'SILVER');
                BOSAAcc.SetRange(BOSAAcc."BOSA Account No", "No.");
                BOSAAcc.SetFilter(BOSAAcc.Status, '<>%1', BOSAAcc.Status::Closed);
                if BOSAAcc.FindSet then begin
                    "Silver Account No" := BOSAAcc."No.";
                    Modify;
                end;
                BOSAAcc.Reset;
                BOSAAcc.SetRange(BOSAAcc."Account Type", '605');
                BOSAAcc.SetRange(BOSAAcc."BOSA Account No", "No.");
                BOSAAcc.SetFilter(BOSAAcc.Status, '<>%1', BOSAAcc.Status::Closed);
                if BOSAAcc.FindSet then begin
                    "FOSA Shares Account No" := BOSAAcc."No.";
                    Modify;
                end;
                BOSAAcc.Reset;
                BOSAAcc.SetRange(BOSAAcc."Account Type", 'BENFUND');
                BOSAAcc.SetRange(BOSAAcc."BOSA Account No", "No.");
                BOSAAcc.SetFilter(BOSAAcc.Status, '<>%1', BOSAAcc.Status::Closed);
                if BOSAAcc.FindSet then begin
                    "Benevolent Fund No" := BOSAAcc."No.";
                    Modify;
                end;
                BOSAAcc.Reset;
                BOSAAcc.SetRange(BOSAAcc."Account Type", '607');
                BOSAAcc.SetRange(BOSAAcc."BOSA Account No", "No.");
                BOSAAcc.SetFilter(BOSAAcc.Status, '<>%1', BOSAAcc.Status::Closed);
                if BOSAAcc.FindSet then begin
                    "Additional Shares Account No" := BOSAAcc."No.";
                    Modify;
                end;
                /*
				{"Share Capital No":='';
				"Deposits Account No":='';
				"FOSA Shares Account No":='';
				"Benevolent Fund No":='';
				"Additional Shares Account No":='';
				MODIFY;
				}
				*/
                /*
				ObjVendor.INIT;
				ObjVendor."No.":='1001-001-'+Customer."No.";
				ObjVendor.Name:=Customer.Name;
				ObjVendor."BOSA Account No":=Customer."No.";
				ObjVendor."Phone No.":=Customer."Phone No.";
				ObjVendor."Mobile Phone No":=Customer."Mobile Phone No";
				ObjVendor."Global Dimension 1 Code":=Customer."Global Dimension 1 Code";
				ObjVendor."Global Dimension 2 Code":=Customer."Global Dimension 2 Code";
				ObjVendor."Creditor Type":=ObjVendor."Creditor Type"::"FOSA Account";
				ObjVendor."Vendor Posting Group":='DEPOSITS';
				ObjVendor."Account Type":='DEPOSIT';
				ObjVendor.INSERT;
				ObjVendor.INIT;
				ObjVendor."No.":='1001-002-'+Customer."No.";
				ObjVendor.Name:=Customer.Name;
				ObjVendor."BOSA Account No":=Customer."No.";
				ObjVendor."Phone No.":=Customer."Phone No.";
				ObjVendor."Mobile Phone No":=Customer."Mobile Phone No";
				ObjVendor."Global Dimension 1 Code":=Customer."Global Dimension 1 Code";
				ObjVendor."Global Dimension 2 Code":=Customer."Global Dimension 2 Code";
				ObjVendor."Creditor Type":=ObjVendor."Creditor Type"::"FOSA Account";
				ObjVendor."Vendor Posting Group":='SHARECAP';
				ObjVendor."Account Type":='SHARECAP';
				ObjVendor.INSERT;
				ObjVendor.INIT;
				ObjVendor."No.":='1001-003-'+Customer."No.";
				ObjVendor.Name:=Customer.Name;
				ObjVendor."BOSA Account No":=Customer."No.";
				ObjVendor."Phone No.":=Customer."Phone No.";
				ObjVendor."Mobile Phone No":=Customer."Mobile Phone No";
				ObjVendor."Global Dimension 1 Code":=Customer."Global Dimension 1 Code";
				ObjVendor."Global Dimension 2 Code":=Customer."Global Dimension 2 Code";
				ObjVendor."Creditor Type":=ObjVendor."Creditor Type"::"FOSA Account";
				ObjVendor."Vendor Posting Group":='BENFUND';
				ObjVendor."Account Type":='BENFUND';
				ObjVendor.INSERT;*/
                /*
				ObjVendor.INIT;
				ObjVendor."No.":='1001-005-'+Customer."No.";
				ObjVendor.Name:=Customer.Name;
				ObjVendor."BOSA Account No":=Customer."No.";
				ObjVendor."Phone No.":=Customer."Phone No.";
				ObjVendor."Mobile Phone No":=Customer."Mobile Phone No";
				ObjVendor."Global Dimension 1 Code":=Customer."Global Dimension 1 Code";
				ObjVendor."Global Dimension 2 Code":=Customer."Global Dimension 2 Code";
				ObjVendor."Creditor Type":=ObjVendor."Creditor Type"::"FOSA Account";
				ObjVendor."Vendor Posting Group":='SILVER';
				ObjVendor."Account Type":='SILVER';
				ObjVendor.INSERT;
				*/
                /*IF MembersRegister.GET("Member Accounts Import Buffer"."Member No") THEN
				BEGIN
				  MembersRegister."Has Silver Deposit":=TRUE;
				  MembersRegister.MODIFY;
				END;*/

            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin
        ;


    end;

    trigger OnPostReport()
    begin
        ;

    end;

    trigger OnPreReport()
    begin
        ;
    end;

    var
        BOSAAcc: Record Vendor;
        ObjVendor: Record Vendor;
        MembersRegister: Record Customer;

    var
}

