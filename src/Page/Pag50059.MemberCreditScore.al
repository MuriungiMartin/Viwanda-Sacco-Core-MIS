#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50059 "Member Credit Score"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Credit Scoring";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Category)
                {
                    ApplicationArea = Basic;
                }
                field("Score Base Value"; "Score Base Value")
                {
                    ApplicationArea = Basic;
                }
                field(Score; Score)
                {
                    ApplicationArea = Basic;
                }
                field("Out Of"; "Out Of")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Summary)
            {
                field("Member Credit Score"; VarMemberCreditScore)
                {
                    ApplicationArea = Basic;
                }
                field("Member Credit Score Description"; VarMemberCreditScoreDescription)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        if ObjMembers.Get("Member No") then begin
            VarMemberCreditScore := ObjMembers."Member Credit Score";
            VarMemberCreditScoreDescription := ObjMembers."Member Credit Score Desc.";
        end;
    end;

    var
        VarMemberCreditScore: Decimal;
        VarMemberCreditScoreDescription: Text;
        ObjMembers: Record Customer;
}

