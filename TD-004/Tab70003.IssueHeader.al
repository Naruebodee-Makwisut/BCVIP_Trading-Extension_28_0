table 70003 "AVTD_Issue Header"
{
    // version AVTHLC1.0

    DrillDownPageID = "AVTD_Inventory List";
    LookupPageID = "AVTD_Inventory List";

    fields
    {
        field(1; Status; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = "Order",Posted;
        }
        field(2; "Issue No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Issue No." <> xRec."Issue No." then begin
                    SalesSetup.Get();
#if not CLEAN24
                    NoSeriesMgt.TestManual(GetNoSeriesCode());
#else
                    codNoSeriesMgt.TestManual(GetNoSeriesCode());
#endif
                    "No. Series" := '';
                end;
            end;
        }
        field(3; Location; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Issued Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Journal Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Template".Name;
        }
        field(7; "Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(8; Type; Option)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 0;
            Editable = false;
            InitValue = "Consumption Journal";
            OptionMembers = "Item Journal","Consumption Journal";
        }
        field(9; "Issue Type"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Positive,Negative,Consumption';
            OptionMembers = Positive,Negative,Consumption;
        }
        field(10; "Production Order"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));

            trigger OnValidate();
            begin
                "Ref. Prod Order No." := "Production Order";
                Modify();

                Clear(ProductionOrder);
                ProductionOrder.SetCurrentKey(Status, "No.");
                ProductionOrder.SetRange("No.", "Production Order");
                if ProductionOrder.Find('-') then
                    Validate("CKD item", ProductionOrder."Source No.");
            end;
        }
        field(11; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Requested By"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser".Code;

            trigger OnValidate();
            begin
                if ("Requested By" <> xRec."Requested By") then begin
                    CreateDefDim(Database::"Salesperson/Purchaser", "Requested By", xRec."Requested By");

                    Clear(ItemJournalLine);
                    ItemJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    ItemJournalLine.SetRange("Journal Template Name", "Journal Template Name");
                    ItemJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
                    if ItemJournalLine.Find('-') then
                        repeat
                            ItemJournalLine.Validate("Salespers./Purch. Code", "Requested By");
                            ItemJournalLine.Modify();
                        until ItemJournalLine.Next() = 0;
                end;
            end;
        }
        field(13; "Posted By"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(14; Remark; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(15; "User Id"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnLookup();
            var
                //LOGIN: Codeunit "User Management";
                xLogin: Codeunit AVF_UserMgtExtCOD418;
            begin
                //LOGIN.ShortUserID("User Id");
                xLogin.ShortUserID("User Id");

                if "User Id" <> xRec."User Id" then
                    "User Id" := xRec."User Id";
            end;
        }
        field(16; "Remark 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup();
            begin
                ShowDocDim();
            end;
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");

                Clear(ItemJournalLine);
                ItemJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                ItemJournalLine.SetRange("Journal Template Name", "Journal Template Name");
                ItemJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
                if ItemJournalLine.Find('-') then
                    repeat
                        ItemJournalLine.Validate("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        ItemJournalLine.Modify();
                    until ItemJournalLine.Next() = 0;
            end;
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");

                Clear(ItemJournalLine);
                ItemJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                ItemJournalLine.SetRange("Journal Template Name", "Journal Template Name");
                ItemJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
                if ItemJournalLine.Find('-') then
                    repeat
                        ItemJournalLine.Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        ItemJournalLine.Modify();
                    until ItemJournalLine.Next() = 0;
            end;
        }
        field(20; "Gen. Bus Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Business Posting Group".Code;
        }

        field(21; "CKD item"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;

            trigger OnValidate();
            var
                ItemMaster: Record Item;
            begin
                if "CKD item" <> '' then begin
                    ItemMaster.Get("CKD item");
                    Description := ItemMaster.Description;
                end else
                    Description := '';

                CreateDefDim(Database::Item, "CKD item", xRec."CKD item");
            end;
        }
        field(22; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(23; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Item Category"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Item Category".Code;
        }
        field(25; "Option Case"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Normal,Scarp,Change Model,Adj';
            OptionMembers = Normal,Scarp,"Change Model",Adj;
        }
        field(26; "Change-Model Refer"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "AVTD_Issue Header"."Issue No." where(Status = filter(Posted));
        }
        field(27; "Ref. Prod Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Production Order"."No." where(Status = const(Released));
        }
        field(28; "Plant No."; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Plant No.';
        }
        field(29; "BOM No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(30; "No. of Batch"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(31; "EVG Job No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(32; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //comment 
        /* field(50100; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center',
                        THA = 'ศูนย์ความรับผิดชอบ';
            Editable = false;
            TableRelation = "Sales Shipment Template";
        } */
        field(33; Consignment; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(34; "Posted Sales Invoice No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //comment from consult
        field(35; "Check Budget"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = '" ,PASS,NOT PASS"';
            OptionMembers = " ",PASS,"NOT PASS";
        }
        field(36; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";

            trigger OnValidate();
            begin
                if ("Customer No." <> xRec."Customer No.") then
                    CreateDefDim(DATABASE::Customer, "Customer No.", xRec."Customer No.");
            end;
        }
        field(37; "Gen. Prod Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";
        }
    }

    keys
    {
        key(Key1; "Issue No.")
        {
        }
        key(Key2; Status, "Posting Date", "Issue No.", "Option Case")
        {
        }
        key(Key3; "Posting Date", "Issue No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestField(Status, Status::Order);

        //Delete Item Journal Line when delete Issue
        Clear(ItemJournalLine);
        ItemJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name");
        ItemJournalLine.SetRange("Journal Template Name", "Journal Template Name");
        ItemJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
        ItemJournalLine.SetRange("Document No.", "Issue No.");
        if not ItemJournalLine.IsEmpty() then
            ItemJournalLine.DeleteAll(true);

        //Delete Batch when delete Issue
        Clear(ItemJournalBatch);
        ItemJournalBatch.SetCurrentKey("Journal Template Name");
        ItemJournalBatch.SetRange(Name, "Journal Batch Name");
        if not ItemJournalBatch.IsEmpty() then
            ItemJournalBatch.DeleteAll(true);
    end;

    trigger OnInsert();
    begin
        Clear(InvSetup);
        InvSetup.Get();

        if "Issue No." = '' then begin
            InvSetup.TestField("AVTD_Issue Nos.");
#if not CLEAN24
            "Issue No." := NoSeriesMgt.GetNextNo(InvSetup."AVTD_Issue Nos.", WorkDate(), true);
#else
            "Issue No." := codNoSeriesMgt.GetNextNo(InvSetup."AVTD_Issue Nos.", WorkDate(), true);
#endif
            "No. Series" := InvSetup."AVTD_Issue Nos.";
        end;

        //InvSetup.TestField("AVTD_Issue Journal Template Name");
        InvSetup.TestField("AVTD_Iss. Gen.Bus Post. Grp");
        InvSetup.TestField("AVTD_Iss. Jnl Template Name");

        JournalTempName := InvSetup."AVTD_Iss. Jnl Template Name";
        "Journal Template Name" := InvSetup."AVTD_Iss. Jnl Template Name";
        Validate("Gen. Bus Posting Group", InvSetup."AVTD_Iss. Gen.Bus Post. Grp");

        "User Id" := UserId();
        "Journal Batch Name" := Format("Issue No.");
        "Document Date" := Today();

        Clear(ItemJournalBatch);
        ItemJournalBatch.SetCurrentKey("Journal Template Name", Name);
        ItemJournalBatch.SetRange("Journal Template Name", JournalTempName);
        ItemJournalBatch.SetRange(Name, "Issue No.");
        if not ItemJournalBatch.FindFirst() then begin
            ItemJournalBatch.Init();
            ItemJournalBatch."Journal Template Name" := JournalTempName;
            ItemJournalBatch.Name := "Issue No.";
            ItemJournalBatch."AVTD_Journal Type" := ItemJournalBatch."AVTD_Journal Type"::Issue;
            ItemJournalBatch.INSERT(true);
        end else begin
            ItemJournalBatch."AVTD_Journal Type" := ItemJournalBatch."AVTD_Journal Type"::Issue;
            ItemJournalBatch.Modify();
        end;
    end;

    trigger OnModify();
    begin
        "User Id" := "User Id";

        if "Posting Date" <> xRec."Posting Date" then begin
            ItemJournal.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
            ItemJournal.SetRange("Journal Batch Name", "Issue No.");
            if ItemJournal.Find('-') then
                repeat
                    ItemJournal."Posting Date" := "Posting Date";
                    ItemJournal.Modify();
                until ItemJournal.Next() = 0;
        end;
    end;

    trigger OnRename();
    begin
        ERROR('Can not rename Issue No.');
    end;

    var
        ItemJournal: Record "Item Journal Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalBatch: Record "Item Journal Batch";
        //ItemJournalTemplate: Record "Item Journal Template";
        InvSetup: Record "Inventory Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        ProductionOrder: Record "Production Order";
        //NoSeries: Record "No. Series";
#if not CLEAN24
        NoSeriesMgt: Codeunit NoSeriesManagement;
#else
        codNoSeriesMgt: Codeunit "No. Series";
#endif
        DimMgt: Codeunit DimensionManagement;
        DimMgtExt: Codeunit AVF_DimensionMgtExt;
        JournalTempName: Code[10];
    /* SalespersonCode: Record "Salesperson/Purchaser";
    DefualDimensionTB: Record "Default Dimension"; */


    procedure ShowPostedDocDim();
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption(), "Issue No."));
    end;

    procedure AssistEdit(OldIssueHeader: Record "AVTD_Issue Header"): Boolean;
    begin
        SalesSetup.Get();
        TestNoSeries();
#if not CLEAN24
        if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldIssueHeader."No. Series", "No. Series") then begin
#else
        if codNoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode(), OldIssueHeader."No. Series", "No. Series") then begin
#endif
            SalesSetup.Get();
            TestNoSeries();
#if not CLEAN24
            NoSeriesMgt.SetSeries("Issue No.");
#else
            "Issue No." := codNoSeriesMgt.GetNextNo("No. Series");
#endif
            exit(true);
        end;
    end;

    local procedure GetNoSeriesCode(): Code[20];
    begin
        Clear(InvSetup);
        InvSetup.Get();
        InvSetup.TestField("AVTD_Issue Nos.");
        exit(InvSetup."AVTD_Issue Nos.");
    end;

    local procedure TestNoSeries(): Boolean;
    begin
        InvSetup.Get();
        InvSetup.TestField("AVTD_Issue Nos.");
    end;

    procedure ShowDocDim();
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgt.EditDimensionSet(
                              "Dimension Set ID", StrSubstNo('%1 %2', Type, "Issue No."),
                              "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        if OldDimSetID <> "Dimension Set ID" then
            Modify();
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        if OldDimSetID <> "Dimension Set ID" then
            Modify();
    end;

    procedure CreateDim("Code": Code[20]; Value: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgtExt.AVGetDimIDUpdate(Code, Value, OldDimSetID, 0);

        if (OldDimSetID <> "Dimension Set ID") then
            Modify();
    end;

    procedure CreateDefDim(TableID: Integer; No: Code[20]; xNo: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        //"Dimension Set ID" := DimMgtExt.AVGetDefaultDimID(TableID, No, xNo, OldDimSetID, 0);
        "Dimension Set ID" := AVGetDefaultDimID(TableID, No, xNo, OldDimSetID, 0);

        if (OldDimSetID <> "Dimension Set ID") then
            Modify();
    end;

    procedure ShowSalePersonName(SalepersonCode: Code[20]): Text[50];
    var
        AVSalesPerson: Record "Salesperson/Purchaser";
    begin
        //AVNVKSTD.004  11.09.12
        //Add Function ShowSalePersonName
        Clear(AVSalesPerson);
        if SalepersonCode <> '' then begin
            AVSalesPerson.SetCurrentKey(AVSalesPerson.Code);
            AVSalesPerson.SetRange(AVSalesPerson.Code, SalepersonCode);
            if AVSalesPerson.FindFirst() then;
        end;
        exit(AVSalesPerson.Name);
        //C- AVNVKSTD.004  11.09.12

    end;

    procedure AVGetDefaultDimID(TableID: Integer; No: code[20]; xNo: code[20]; InheritFromDimSetID: Integer; InheritFromTableNo: Integer): Integer;
    var
        DimVal: Record "Dimension Value";
        /* DefaultDimPriority1: Record "Default Dimension Priority";
        DefaultDimPriority2: Record "Default Dimension Priority"; */
        DefaultDim: Record "Default Dimension";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        TempDimSetEntry0: Record "Dimension Set Entry" temporary;
        DimMgt1: Codeunit DimensionManagement;
        /* i: Integer;
        j: Integer; 
        NoFilter: code[20];*/
        NewDimSetID: Integer;

    begin
        //AVNVKNAV7 11.02.13
        //add function for get dimID update by filed 11.02.13
        GetGLSetup();
        if InheritFromDimSetID > 0 then
            DimMgt.GetDimensionSet(TempDimSetEntry0, InheritFromDimSetID);
        TempDimBuf2.Reset();
        TempDimBuf2.DeleteAll();
        if TempDimSetEntry0.FindSet() then
            repeat
                TempDimBuf2.Init();
                TempDimBuf2."Table ID" := InheritFromTableNo;
                TempDimBuf2."Entry No." := 0;
                TempDimBuf2."Dimension Code" := TempDimSetEntry0."Dimension Code";
                TempDimBuf2."Dimension Value Code" := TempDimSetEntry0."Dimension Value Code";
                TempDimBuf2.Insert();
            until TempDimSetEntry0.Next() = 0;

        Clear(DefaultDim);
        DefaultDim.SetRange("Table ID", TableID);
        DefaultDim.SetRange("No.", xNo);
        if DefaultDim.FindSet() then
            repeat
                TempDimBuf2.Reset();
                TempDimBuf2.SetRange("Dimension Code", DefaultDim."Dimension Code");
                if TempDimBuf2.FindFirst() then
                    TempDimBuf2.Delete();
            until DefaultDim.Next() = 0;

        Clear(DefaultDim);
        DefaultDim.SetRange("Table ID", TableID);
        DefaultDim.SetRange("No.", No);
        if DefaultDim.FindSet() then
            repeat
                if DefaultDim."Dimension Value Code" <> '' then begin
                    TempDimBuf2.Init();
                    TempDimBuf2."Table ID" := DefaultDim."Table ID";
                    TempDimBuf2."Entry No." := 0;
                    TempDimBuf2."Dimension Code" := DefaultDim."Dimension Code";
                    TempDimBuf2."Dimension Value Code" := DefaultDim."Dimension Value Code";
                    TempDimBuf2.Insert();
                end;
            until DefaultDim.Next() = 0;

        TempDimBuf2.Reset();
        if TempDimBuf2.FindSet() then begin
            repeat
                DimVal.Get(TempDimBuf2."Dimension Code", TempDimBuf2."Dimension Value Code");
                TempDimSetEntry."Dimension Code" := TempDimBuf2."Dimension Code";
                TempDimSetEntry."Dimension Value Code" := TempDimBuf2."Dimension Value Code";
                TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                if TempDimSetEntry.Insert() then;
            until TempDimBuf2.Next() = 0;
            NewDimSetID := DimMgt1.GetDimensionSetID(TempDimSetEntry);
        end;
        exit(NewDimSetID);
        //C-AVNVKNAV7 11.02.13
    end;

    procedure GetGLSetup();
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get();
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := true;
        end;
    end;

    var
        TempDimBuf2: Record "Dimension Buffer" temporary;
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];
}

