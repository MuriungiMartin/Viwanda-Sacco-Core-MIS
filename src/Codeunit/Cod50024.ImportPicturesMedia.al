#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50024 "Import Pictures Media"
{

    trigger OnRun()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
    begin
        ObjAccountAgents.Reset;
        if ObjAccountAgents.Find('-') then begin
            repeat
                ClientFileName := FILE_PATH + 'DefaultImage.jpg';
                ClientFileName := FILE_PATH + ObjAccountAgents."BOSA No." + '.jpeg';
                FileName := FileManagement.UploadFileSilent(ClientFileName);
                if FileName <> '' then begin
                    Clear(ObjAccountAgents.Picture);
                    ObjAccountAgents.Picture.ImportFile(FileName, ClientFileName);
                    if not ObjAccountAgents.Insert(true) then
                        ObjAccountAgents.Modify(true);

                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            until ObjAccountAgents.Next = 0;
        end;



        ObjAccountAgents.Reset;
        if ObjAccountAgents.Find('-') then begin
            repeat
                ClientFileName := FILE_PATH_S + 'DefaultImage.jpg';
                ClientFileName := FILE_PATH_S + ObjAccountAgents."BOSA No." + '.jpeg';
                FileName := FileManagement.UploadFileSilent(ClientFileName);
                if FileName <> '' then begin
                    Clear(ObjAccountAgents.Signature);
                    ObjAccountAgents.Signature.ImportFile(FileName, ClientFileName);
                    if not ObjAccountAgents.Insert(true) then
                        ObjAccountAgents.Modify(true);

                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            until ObjAccountAgents.Next = 0;
        end;
    end;

    var
        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        ObjMember: Record Customer;
        FILE_PATH: label 'D:\Softwares\ksacco\Photo\';
        FILE_PATH_S: label 'D:\Softwares\ksacco\Sign\';
        ObjAccountAgents: Record "Account Agent Details";
}

