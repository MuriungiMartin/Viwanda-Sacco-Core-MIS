
Report 50611 "Update Accounts"
{
    RDLCLayout = 'Layouts/UpdateAccounts.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(Vendor; Vendor)
        {

            trigger OnAfterGetRecord();
            begin
                /*
				ObjCust.RESET;
				ObjCust.SETRANGE(ObjCust."No.","BOSA Account No");
				IF ObjCust.FINDSET THEN BEGIN
				  Address:=ObjCust.Address;
				  "Post Code":=ObjCust."Post Code";
				  "ID No.":=ObjCust."ID No.";
				  "Global Dimension 1 Code":='FOSA';
				  "Global Dimension 2 Code":=ObjCust."Global Dimension 2 Code";
				  "Creditor Type":="Creditor Type"::"FOSA Account";
				  "Mobile Phone No":=ObjCust."Mobile Phone No";
				  "Phone No.":=ObjCust."Phone No.";
				  "E-Mail":=ObjCust."E-Mail";
				  MODIFY;
				  END;
				ObjAccountTypes.RESET;
				ObjAccountTypes.SETRANGE(ObjAccountTypes.Code,"Account Type");
				IF ObjAccountTypes.FINDSET THEN BEGIN
				"Vendor Posting Group":=ObjAccountTypes."Posting Group";
				MODIFY;
				  END;
				  */

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


    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

    end;

    var
        ObjAccountTypes: Record "Account Types-Saving Products";
        ObjCust: Record Customer;

    var
}