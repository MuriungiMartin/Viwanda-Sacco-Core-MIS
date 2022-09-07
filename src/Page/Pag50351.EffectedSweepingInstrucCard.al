#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50351 "Effected Sweeping Instruc Card"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Member Sweeping Instructions";
    SourceTableView = where(Effected = filter(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No"; "Document No")
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
                field("Monitor Account"; "Monitor Account")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account Type"; "Monitor Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account Type Desc"; "Monitor Account Type Desc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monitor Account Type Description';
                }
                field("Check Minimum Threshold"; "Check Minimum Threshold")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sweep From Investment Min Threshold';
                    ToolTip = 'Sweep From Investment Account Amount Below Minimum Threshold';
                }
                field("Check Maximum Threshold"; "Check Maximum Threshold")
                {
                    ApplicationArea = Basic;
                    Caption = 'Swep From Monitor Account Above Max Threshold';
                }
                group("Minimum Threshold")
                {
                    field("Minimum Account Threshold"; "Minimum Account Threshold")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Maximum Threshold")
                {
                    field("Maximum Account Threshold"; "Maximum Account Threshold")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Investment Account"; "Investment Account")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Account Type"; "Investment Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Account Type Desc"; "Investment Account Type Desc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Investment Account Type Description';
                }
                field("Schedule Frequency"; "Schedule Frequency")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        WeeklyVisible := false;
                        MonthlyVisible := false;
                        if "Schedule Frequency" = "schedule frequency"::Weekly then begin
                            WeeklyVisible := true;
                        end;
                        if "Schedule Frequency" = "schedule frequency"::Monthly then begin
                            MonthlyVisible := true;
                        end;
                    end;
                }
                group("Weekly ")
                {
                    Visible = WeeklyVisible;
                    field("Day Of Week"; "Day Of Week")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Day Of Week';
                    }
                }
                group(Monthly)
                {
                    Visible = MonthlyVisible;
                    field("Day Of Month"; "Day Of Month")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Days Of Month e.g. 05,12,20';
                    }
                }
                field("Created On"; "Created On")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                }
                field(Effected; Effected)
                {
                    ApplicationArea = Basic;
                }
                field("Effected on"; "Effected on")
                {
                    ApplicationArea = Basic;
                }
                field("Last Execution"; "Last Execution")
                {
                    ApplicationArea = Basic;
                }
                field(Stopped; Stopped)
                {
                    ApplicationArea = Basic;
                }
                field("Stopped By"; "Stopped By")
                {
                    ApplicationArea = Basic;
                }
                field("Stopped On"; "Stopped On")
                {
                    ApplicationArea = Basic;
                }
                label(Control32)
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
            action("Stop Instruction")
            {
                ApplicationArea = Basic;
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Status := Status::Stopped;
                    Stopped := true;
                    "Stopped By" := UserId;
                    "Stopped On" := Today();
                    Modify;
                    Message('Standing instruction stopped successfully');
                end;
            }
        }
    }

    var
        WeeklyVisible: Boolean;
        MonthlyVisible: Boolean;
}

