codeunit 50062 "GSTN Management"
{

    trigger OnRun()
    var
        Msg: Text;
    begin
        //Authenticate;
        //MESSAGE('%1',CheckGSTN('07AAACO0305P1ZJ'));
        CheckUpdateGSTN(1, '11', '07AAACO0305P1ZJ', Msg);
    end;

    var
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        TmpBlob: Codeunit "Temp Blob";
        /*  RequestStr: DotNet Stream;
         StringReader: DotNet StringReader;
         JsonTextReader: DotNet JsonTextReader;
         ServicePointManager: DotNet ServicePointManager;
         SecurityProtocol: DotNet SecurityProtocolType; */
        MessageText: Text;
        GSTNNo: Code[20];
        LocationCode: Code[10];
        /*  Json: DotNet String;
         access_token: Text;
         StringBuilder: DotNet StringBuilder;
         StringWriter: DotNet StringWriter; */
        txtUserName: Text;
        txtPassword: Text;
        txtapiaccesskey: Text;
    /*  JsonTextWriter: DotNet JsonTextWriter;
     StreamWriter: DotNet StreamWriter;
     StreamReader: DotNet StreamReader;
     Encoding: DotNet Encoding; */


    procedure Authenticate(): Text
    var
        FL: File;
        OutStrm: OutStream;
        ResponseInStream_L: InStream;
        /* HttpStatusCode_L: DotNet HttpStatusCode;
        ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        DataExch: Record "Data Exch. Field";
        JSONManagement: Codeunit "JSON Management";
        rSalInvHdr: Record "Sales Invoice Header";
        rSalCrMemoHdr: Record "Sales Cr.Memo Header";
        rTrfShpHdr: Record "Transfer Shipment Header";
        rLocation: Record Location;
    begin
        CLEAR(HttpWebRequestMgt);
        txtUserName := 'APIGSTINValidationuser@orientbell.eyasp.com';
        txtPassword := 'uNDhnvFVMaJYLgPQcP410Z8gSQ6UCpgBU6uLrLjc+eClt05faR2I2Ovk5C+9U47yCFPjDCYNOdr2aDHaP17Qq1XTqV4gaUw4zs/3yxLyF/N1A0HyZYnqFVuezMoMpTJFBO5IvQqU40iay+PlTypcLRGcDPC+mKX43oc3PgnJHXsLxo20qyc4RhUpXEFyUXUbu9DV7J7raVc52um3U/nTstpaE1ZnmYq9pNp59+rzzSLnhzkmJPk1w4g+t8AD3Ja67p8TUkgbX0W3ofDb54VoRjz/RVIaOL9UJqNUIuzFSVleRPT7oIh5fczfA2dQE94mhBC5HBB3y64JCcwtJG3OsQ==';
        //txtPassword := 'Intgdigigst#12';
        //txtapiaccesskey := 'l7xxf44b67ae82784f5a99d39eb576a29aea';

        txtapiaccesskey := 'iWWNugG1r4mGBkWRHY69s+J6K4mph52ff9b6rQAlmpg2lVQABTJUyuCZzn6IZ3CK9KUQO9TY8Rfzn+TIbFtRjPlb1oettZPb5mZBN+TBI8ZYILmylvyZEqDDyucOjL18n0QRYs7FiSdSoAnDUF3MiOpnWvEBt4JiJnbdQNqKIpdz2WY2xjD6m26M0im56QXdYq9KKpi2lgZ8s/knahVC/uB3LmrObrqgRS941JkZAEj6YJWnWHppTID8+MX4QpQKe9HDOLfxSUZkb7OLUqd3WH6OCOr+j6RmWNcA7tI0On7Qd3ekANkQGE4TZa7JI2z9QWp7J0ldl5AQIHPI6+84Ig==';


        //HttpWebRequestMgt.Initialize(rLocation."E-InvAuthenticateURL");
        //'https://eapi.eyasp.com/eapi/v2.0/authenticate'
        //https://api.eyasp.in/aspapi/v1.1/authenticate

        /* HttpWebRequestMgt.Initialize('https://api.eyasp.com/aspapi/v1.1/authenticate');
        HttpWebRequestMgt.DisableUI;
        HttpWebRequestMgt.SetMethod('POST');
        //HttpWebRequestMgt.SetReturnType('application/json');
        HttpWebRequestMgt.SetContentType('application/x-www-form-urlencoded');
        HttpWebRequestMgt.AddHeader('username', txtUserName);
        HttpWebRequestMgt.AddHeader('password', txtPassword);
        HttpWebRequestMgt.AddHeader('api_key', txtapiaccesskey);
        //HttpWebRequestMgt.AddBody(GetClientFile + 'accesstoken.txt');
        ServicePointManager.SecurityProtocol(SecurityProtocol.Tls12); // new line
        CLEAR(JSONManagement);
        // TmpBlob.INIT;
        //TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
            ResponseInStream_L.READ(ResponseText);
            Json := ResponseText;
            //Added
            IF (ResponseText = '') OR (ResponseText = '[]') THEN
                EXIT;
            JSONManagement.InitializeObject(ResponseText);
            //Added
            //MESSAGE(JSONManagement.GetValue('accesstoken'));
            ReadJSon(Json, DataExch);
            IF GetJsonNodeValue('status') = '0' THEN
                ERROR(GetJsonNodeValue('errorDetails..errorDesc'))
            ELSE BEGIN
                access_token := JSONManagement.GetValue('accesstoken');//GetJsonNodeValue('accessToken')
            END;
        END
        ELSE
            ERROR('Network Issue, Please try again'); */
    end;


    procedure CheckGSTN(GSTN: Code[16]): Text
    var
        FL: File;
        ResponseInStream_L: InStream;
        /*  HttpStatusCode_L: DotNet HttpStatusCode;
         ResponseHeaders_L: DotNet NameValueCollection; */
        ResponseText: Text;
        JString: Text;
        OutStrm: OutStream;
        DataExch: Record "Data Exch. Field";
    begin
        StartJason;
        AddToJason('gstin', GSTN); //Test
        EndJason;
        GetJason;
        /* IF FILE.EXISTS(GetClientFile + 'J.txt') THEN
            ERASE(GetClientFile + 'J.txt');
        FL.CREATE(GetClientFile + 'J.txt');
        FL.CREATEOUTSTREAM(OutStrm);
        OutStrm.WRITETEXT(FORMAT(Json));
        FL.CLOSE;
        //MESSAGE('%1',Json);

        HttpWebRequestMgt.Initialize('https://api.eyasp.com/aspapi/v1.1/gstinvalidation');
        HttpWebRequestMgt.DisableUI;
        HttpWebRequestMgt.SetMethod('POST');
        HttpWebRequestMgt.SetReturnType('application/json');
        HttpWebRequestMgt.SetContentType('application/json');
        HttpWebRequestMgt.AddHeader('accesstoken', access_token);
        HttpWebRequestMgt.AddHeader('api_key', txtapiaccesskey);

        HttpWebRequestMgt.AddBody(GetClientFile + 'J.txt');

        // 15578   TmpBlob.INIT;
        // 15578  TmpBlob.Blob.CREATEINSTREAM(ResponseInStream_L);
        IF HttpWebRequestMgt.GetResponse(ResponseInStream_L, HttpStatusCode_L, ResponseHeaders_L) THEN BEGIN
            ResponseInStream_L.READ(ResponseText);
            Json := ResponseText;
            //    MESSAGE('%1',ResponseText);
            ReadJSon(Json, DataExch);
            IF GetJsonNodeValue('details..gstindetails.sts') = 'Active' THEN
                EXIT(GetJsonNodeValue('details..gstindetails.sts'))
            ELSE BEGIN
                EXIT(GetJsonNodeValue('details..gstindetails.sts'));//GetJsonNodeValue('accessToken')
            END;
        END; */
    end;

    local procedure GetJason()
    begin
        // Json := StringBuilder.ToString;
    end;

    local procedure GetClientFile(): Text
    var
    /*  [RunOnClient]
     ClientAppFile: DotNet Path; */
    begin
        EXIT('C:\\WebRequest');
    end;


    /* procedure ReadJSon(var String: DotNet String; var TempPostingExchField: Record "Data Exch. Field" temporary)
    var
        //JsonToken: DotNet JsonToken;
        PrefixArray: DotNet Array;
        PrefixString: DotNet String;
        PropertyName: Text;
        ColumnNo: Integer;
        InArray: array[1000] of Boolean;
        LineNo: Integer;
        NewLn: Integer;
        T1221_L: Record "Data Exch. Field";
        Intn: Integer;
    begin
        PrefixArray := PrefixArray.CreateInstance(GETDOTNETTYPE(String), 250);
        StringReader := StringReader.StringReader(String);
        JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
        LineNo := 0;
        //
        T1221_L.DELETEALL;
        TempPostingExchField.RESET;
        CLEAR(TempPostingExchField);
        TempPostingExchField.DELETEALL;
       
    end;

 */
    /* procedure ReadFirstJSonValue(var String: DotNet String; ParameterName: Text) ParameterValue: Text
    var
        //JsonToken: DotNet JsonToken;
        PropertyName: Text;
    begin
        
        StringReader := StringReader.StringReader(String);
        JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
        WHILE JsonTextReader.Read DO
            CASE TRUE OF
                JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
                    PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
                NOT ISNULL(JsonTextReader.Value):
                    //JsonTextReader.TokenType.CompareTo(JsonToken.) = 0 :
                    BEGIN
                        ParameterValue := FORMAT(JsonTextReader.Value, 0, 9);
                        EXIT;
                    END;
            END;
            
    end; */

    local procedure GetJsonNodeValue(NodeId: Text[30]): Text
    var
        DataExch: Record "Data Exch. Field";
    begin
        CLEAR(MessageText);
        DataExch.RESET;
        DataExch.SETRANGE("Node ID", NodeId);
        IF DataExch.FINDFIRST THEN
            MessageText := DataExch.Value;
        EXIT(MessageText);
    end;

    local procedure SetINIT()
    begin
        /* CLEAR(StringBuilder);
        CLEAR(StringWriter);
        CLEAR(JsonTextWriter);
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter); */
    end;

    local procedure ExportAsJson(FileName: Text[20])
    var
        TempFile: File;
        ToFile: Variant;
        NewStream: InStream;
    begin
        // TempFile.CREATETEMPFILE;
        // 15578   TempFile.WRITE(StringBuilder.ToString);
        // TempFile.CREATEINSTREAM(NewStream);
        ToFile := FileName + '.json';
        DOWNLOADFROMSTREAM(NewStream, 'e-Invoice', '', 'JSON files|*.json|All files (*.*)|*.*', ToFile);
        // TempFile.CLOSE;
    end;

    local procedure StartJason()
    begin
        SetINIT;
        // JsonTextWriter.WriteStartObject;
    end;

    local procedure AddToJason(Variablename: Text; Variable: Variant)
    begin
        // JsonTextWriter.WritePropertyName(Variablename);
        // JsonTextWriter.WriteValue(FORMAT(Variable, 0, 9));
    end;

    local procedure EndJason()
    begin
        // JsonTextWriter.WriteEndObject;
    end;


    procedure CreateGSTNLog(PartyType: Option; PartyNo: Code[20]; GSTNNo: Code[20]; Status: Text): Boolean
    var
        GSTNLogEntry: Record "GSTN Log Entry";
        LastEntryNo: Integer;
    begin
        GSTNLogEntry.RESET;
        IF GSTNLogEntry.FINDLAST THEN
            LastEntryNo := GSTNLogEntry."Entry No." + 1
        ELSE
            LastEntryNo := 1;

        GSTNLogEntry.INIT;
        GSTNLogEntry."Entry No." := LastEntryNo;
        GSTNLogEntry.Type := PartyType;
        GSTNLogEntry."No." := PartyNo;
        GSTNLogEntry."GSTN No." := GSTNNo;
        GSTNLogEntry.Date := CURRENTDATETIME;
        GSTNLogEntry."Checked By" := USERID;
        GSTNLogEntry.Status := Status;
        GSTNLogEntry.INSERT;
    end;


    procedure CheckUpdateGSTN(PartyType: Option; PartyNo: Code[20]; GSTNNo: Code[20]; var Status: Text): Boolean
    var
        GSTNLogEntry: Record "GSTN Log Entry";
        LastEntryNo: Integer;
        LastStatus: Text;
    begin
        IF GSTNNo = '' THEN EXIT;
        Authenticate;
        LastStatus := CheckGSTN(GSTNNo);
        CreateGSTNLog(PartyType, PartyNo, GSTNNo, LastStatus);

        IF LastStatus <> 'Active' THEN
            EXIT(TRUE);
    end;
}

