page 70040 "AVTD_PR Line List"
{
    // version AVTHLC1.0

    // Microsoft Dynamic NAV
    // ----------------------------------------
    // Project: Localization TH
    // AVNPSTD : Neramit Pankpiean
    // 
    // Project: MACO
    // AVWIMACO : Waraporn Intusut
    // 
    // No.   Date         Sign  Description
    // ----------------------------------------
    // 001   22.08.2008   AVNPSTD   Add Code for copy Quote Localization.
    //                              Function Get Doc No.
    // 002   13.11.2010   AVWIMACO  Add Code for Create Dimension Line on button OK trigger <Control1000000037> - OnPush()
    // 003   23.11.2010   AVWIMACO  Add Code for Close PR if already get All Line on Button OK Trigger <Control1000000037> - OnPush()
    Caption = 'PR Line List';
    DeleteAllowed = false;
    InsertAllowed = false;
    //Editable = true;
    //SourceTableTemporary = true;
    PageType = Worksheet;
    SourceTable = "Purchase Line";
    SourceTableView = sorting("Document Type", "Document No.", "Line No.");
    /* SourceTableView = sorting("Document Type", "Document No.", "Line No.")
                      where("Document Type" = filter(Quote),
                            "AVTD_Ref. Doc. No." = filter('')); */

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Used Line"; Rec."AVTD_Used Line")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."AVTD_Used Line" then begin
                            if Rec."AVTD_COPY PR User Id" <> '' then
                                Error('This PR %1 already use for PO %2', Rec."Document No.", "PURC. H TB"."No.");
                            Rec."AVTD_Set PO No." := "PURC. H TB"."No.";
                            Rec."AVTD_COPY PR User Id" := UserId;
                        end else begin
                            Rec."AVTD_Set PO No." := '';
                            Rec."AVTD_COPY PR User Id" := '';
                        end;
                    end;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Standard;
                    StyleExpr = true;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("AVTD_Purchase Status"; Rec."AVTD_Purchase Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnInit()
    var
        PurchHeader: Record "Purchase Header";

    begin
        Rec.Reset();
        Rec.SetRange("Document Type", Rec."Document Type"::Quote);
        Rec.SetFilter("AVTD_Ref. Doc. No.", '=%1', '');
        Rec.SetFilter("No.", '<>%1', ''); //19.11.2020
        if Rec.FindSet() then
            repeat
                Clear(PurchHeader);
                if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
                    if not ((PurchHeader."AVTD_Finished PR") or (PurchHeader."AVTD_Cancel PR")) then //19.11.2020
                        if PurchHeader.Status = PurchHeader.Status::Released then
                            Rec.Mark(true);
            until Rec.Next() = 0;
    end;

    trigger OnOpenPage()
    begin
        Rec.MarkedOnly(true);
    end;
    /* trigger OnAfterGetRecord()
    begin
        rec.MarkedOnly(true);
    end; */

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if CloseAction in [Action::OK, Action::LookupOK] then
            OKOnPush()
        else
            if CloseAction in [Action::Cancel, Action::LookupCancel] then begin
                Rec.SetRange("AVTD_COPY PR User Id", UserID);
                if Rec.FindSet(true) then begin
                    Rec.ModifyAll("AVTD_Used Line", false);
                    Rec.ModifyAll("AVTD_Set PO No.", '');
                    Rec.ModifyAll("AVTD_COPY PR User Id", '');
                end;
            end;
    end;

    var
        "PURC. H TB": Record "Purchase Header";
        "PURC. L TB": Record "Purchase Line";
        "PURC. L TB1": Record "Purchase Line";
        "PURCHASE L TB": Record "Purchase Line";
        PurchLine: Record "Purchase Line";
    /* AVPurchH: Record "Purchase Header";
    AVPurchL: Record "Purchase Line"; */

    procedure "GET DOCU NO."("Purchase H TB": Record "Purchase Header");
    begin
        "PURC. H TB" := "Purchase H TB";
    end;

    local procedure OKOnPush();
    var
        TempPurch: Record "Purchase Header" temporary;
        modPurchHdr: Record "Purchase Header";
        gPurchLine: Record "Purchase Line";
        NoOfDocLine: Integer;
        NoOfUsedLine: Integer;
    begin
        Clear(TempPurch);
        //AVNPSTD.001
        "PURC. L TB".SetFilter("AVTD_Ref. Doc. No.", '%1', '');
        "PURC. L TB".SetRange("AVTD_Used Line", true);
        "PURC. L TB".SetRange("AVTD_COPY PR User Id", UserId);
        if "PURC. L TB".Find('-') then begin
            repeat
                //keep purchase quote no for check update at the end of process    
                TempPurch.Reset();
                TempPurch.SetRange("Document Type", "PURC. L TB"."Document Type");
                TempPurch.SetRange("No.", "PURC. L TB"."Document No.");
                if TempPurch.IsEmpty then begin
                    TempPurch.Init();
                    TempPurch."Document Type" := "PURC. L TB"."Document Type";
                    TempPurch."No." := "PURC. L TB"."Document No.";
                    TempPurch.Insert()
                end;

                "PURCHASE L TB".Init();
                "PURCHASE L TB"."Document Type" := "PURCHASE L TB"."Document Type"::Order;
                "PURCHASE L TB"."Document No." := "PURC. H TB"."No.";

                "PURC. L TB1".SetRange("Document Type", "PURC. L TB1"."Document Type"::Order);
                "PURC. L TB1".SetFilter("Document No.", "PURC. H TB"."No.");
                if "PURC. L TB1".Find('+') then
                    "PURCHASE L TB"."Line No." := "PURC. L TB1"."Line No." + 1000
                else
                    "PURCHASE L TB"."Line No." := 10000;
                /*
                if "PURC. L TB".Type = "PURC. L TB".Type::"G/L Account" then
                    "PURCHASE L TB".Validate(Type, "PURC. L TB".Type::"G/L Account")
                else
                    if "PURC. L TB".Type = "PURC. L TB".Type::Item then
                        "PURCHASE L TB".Validate(Type, "PURC. L TB".Type::Item)
                    else
                        if "PURC. L TB".Type = "PURC. L TB".Type::"Fixed Asset" then
                            "PURCHASE L TB".Validate(Type, "PURC. L TB".Type::"Fixed Asset")
                        else
                            if "PURC. L TB".Type = "PURC. L TB".Type::"Charge (Item)" then
                                "PURCHASE L TB".Validate(Type, "PURC. L TB".Type::"Charge (Item)");
                */
                case "PURC. L TB".Type of
                    "PURC. L TB".Type::"G/L Account":
                        "PURCHASE L TB".Validate(Type, "PURC. L TB".Type::"G/L Account");
                    "PURC. L TB".Type::"Item":
                        "PURCHASE L TB".Validate(Type, "PURC. L TB".Type::Item);
                    "PURC. L TB".Type::"Fixed Asset":
                        "PURCHASE L TB".Validate(Type, "PURC. L TB".Type::"Fixed Asset");
                    "PURC. L TB".Type::"Charge (Item)":
                        "PURCHASE L TB".Validate(Type, "PURC. L TB".Type::"Charge (Item)");
                end;

                if "PURC. L TB"."No." <> '' then
                    "PURCHASE L TB".Validate("No.", "PURC. L TB"."No.");
                "PURCHASE L TB".Description := "PURC. L TB".Description;
                "PURCHASE L TB"."Description 2" := "PURC. L TB"."Description 2";
                "PURCHASE L TB".Validate("Buy-from Vendor No.", "PURC. H TB"."Buy-from Vendor No.");
                if "PURC. L TB"."No." <> '' then begin
                    "PURCHASE L TB".Validate(Quantity, "PURC. L TB".Quantity);
                    "PURCHASE L TB".Validate("Location Code", "PURC. L TB"."Location Code");
                    "PURCHASE L TB".Validate("Unit of Measure Code", "PURC. L TB"."Unit of Measure Code");
                    "PURCHASE L TB".Validate("Direct Unit Cost", "PURC. L TB"."Direct Unit Cost");
                    //comment not use step line discount%
                    /* "PURCHASE L TB".Validate("Line Discount 1 %", "PURC. L TB"."Line Discount 1 %");
                    "PURCHASE L TB".Validate("Line Discount 2 %", "PURC. L TB"."Line Discount 2 %");
                    "PURCHASE L TB".Validate("Line Discount 3 %", "PURC. L TB"."Line Discount 3 %"); */
                    "PURCHASE L TB".Validate("Line Discount %", "PURC. L TB"."Line Discount %");
                    "PURCHASE L TB"."Inv. Discount Amount" := "PURC. L TB"."Inv. Discount Amount";
                end;
                //"PURCHASE L TB"."Budget Type" := "PURC. L TB"."Budget Type";
                "PURCHASE L TB"."Job No." := "PURC. L TB"."Job No.";
                "PURCHASE L TB"."Job Task No." := "PURC. L TB"."Job Task No.";
                //"PURCHASE L TB"."Dimension Set ID" := "PURC. L TB"."Dimension Set ID";
                //comment not use for these extension
                //AVNP_Fixed_LC.001
                //"PURCHASE L TB"."G/L_Temp" := "PURC. L TB"."G/L_Temp";
                //C-AVNP_Fixed_LC.001

                "PURCHASE L TB".Insert();
                if "PURC. L TB"."No." <> '' then begin
                    "PURCHASE L TB".Validate("Shortcut Dimension 2 Code", "PURC. L TB"."Shortcut Dimension 2 Code");
                    "PURCHASE L TB".Validate("Shortcut Dimension 1 Code", "PURC. L TB"."Shortcut Dimension 1 Code");
                    "PURCHASE L TB".Validate("Gen. Bus. Posting Group", "PURC. H TB"."Gen. Bus. Posting Group");
                    "PURCHASE L TB".Validate("AVF_WHT Business Posting Group", "PURC. H TB"."AVF_WHT Business Posting Group");
                    "PURCHASE L TB".Validate("Gen. Prod. Posting Group", "PURC. L TB"."Gen. Prod. Posting Group");
                    "PURCHASE L TB".Validate("VAT Prod. Posting Group", "PURC. L TB"."VAT Prod. Posting Group");
                    "PURCHASE L TB".Validate("AVF_WHT Product Posting Group", "PURC. L TB"."AVF_WHT Product Posting Group");
                end;

                "PURCHASE L TB"."AVTD_Ref. Doc. No." := "PURC. L TB"."Document No.";
                "PURCHASE L TB"."AVTD_Ref. Line No." := "PURC. L TB"."Line No.";

                //"PURCHASE L TB"."Budget Name" := "PURC. L TB"."Budget Name";
                "PURCHASE L TB".Description := "PURC. L TB".Description;
                "PURCHASE L TB"."Description 2" := "PURC. L TB"."Description 2";

                //"PURCHASE L TB".Remark := "PURC. L TB".Remark;
                //"PURCHASE L TB"."Budget Payment Method" := "PURC. L TB"."Budget Payment Method";
                //"PURCHASE L TB"."Purchase Sub Type" := "PURC. L TB"."Purchase Sub Type";
                OnCopyPRLine("PURCHASE L TB", "PURC. L TB");
                "PURCHASE L TB".Modify();


                "PURC. L TB"."AVTD_Ref. Doc. No." := "PURC. H TB"."No.";
                "PURC. L TB"."AVTD_Ref. Line No." := "PURCHASE L TB"."Line No.";
                "PURC. L TB"."AVTD_Used Line" := false;
                OnBeforeModifyRefPRLine("PURC. L TB", "PURCHASE L TB");
                "PURC. L TB".Modify();

            //AVWIMACO.003 23.11.2010
            //Add Code for Close PR if already get All Line on Button OK Trigger <Control1000000037> - OnPush()
            //waiting confirm how to do next
            /* Clear(AVPurchH);
            AVPurchH.SetCurrentKey(AVPurchH."Document Type", AVPurchH."No.");
            AVPurchH.SetRange(AVPurchH."No.", "PURC. L TB"."Document No.");
            AVPurchH.SetRange(AVPurchH."Document Type", "PURC. L TB"."Document Type");
            if AVPurchH.FindFirst() then begin
                Clear(AVPurchL);
                AVPurchL.SetCurrentKey(AVPurchL."Document Type", AVPurchL."Document No.");
                AVPurchL.SetRange(AVPurchL."Document No.", AVPurchH."No.");
                AVPurchL.SetRange(AVPurchL."Document Type", AVPurchH."Document Type");
                AVPurchL.SetFilter(AVPurchL."FNPO001_Ref. Doc. No.", '%1', '');
                if not AVPurchL.FindFirst() then begin
                    AVPurchH.FINISHED := AVPurchH.FINISHED::FINISHED;
                    AVPurchH.Modify();
                end;
            end; */
            //C-AVWIMACO.003 23.11.2010

            until ("PURC. L TB".Next() = 0);
            //Try to find purchase quote line that all used line to PO 
            TempPurch.Reset();
            if TempPurch.FindSet() then begin
                Clear(NoOfDocLine);
                Clear(NoOfUsedLine);
                repeat
                    Clear(gPurchLine);
                    gPurchLine.SetRange("Document Type", TempPurch."Document Type");
                    gPurchLine.SetRange("Document No.", TempPurch."No.");
                    gPurchLine.SetFilter("No.", '<>%1', '');
                    gPurchLine.SetLoadFields("AVTD_Ref. Doc. No.");
                    if gPurchLine.FindSet() then begin
                        repeat
                            NoOfDocLine += 1;
                            if gPurchLine."AVTD_Ref. Doc. No." <> '' then
                                NoOfUsedLine += 1;
                        until gPurchLine.Next() = 0;
                    end;
                    if NoOfDocLine = NoOfUsedLine then begin
                        Clear(modPurchHdr);
                        modPurchHdr.SetRange("Document Type", TempPurch."Document Type");
                        modPurchHdr.SetRange("No.", TempPurch."No.");
                        if modPurchHdr.FindSet(true) then begin
                            modPurchHdr."AVTD_Finished PR" := true;
                            modPurchHdr.Modify();
                        end;
                    end;
                until TempPurch.Next() = 0;
            end;
        end;
        //C-AVNPSTD.001
        //Waiting confirm how to do next
        /* Clear(AVPurchH);
        AVPurchH.SetCurrentKey(AVPurchH."Document Type", AVPurchH."No.");
        AVPurchH.SetRange(AVPurchH."No.", "PURC. L TB"."Document No.");
        AVPurchH.SetRange(AVPurchH."Document Type", "PURC. L TB"."Document Type");
        if AVPurchH.FindFirst() then begin
            "PURC. H TB"."Inv. Discount %" := AVPurchH."Inv. Discount %";
            "PURC. H TB".Modify();
        end; */
    end;
    /* [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShippingOptions(var SalesHeader: Record "Sales Header"; ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address")
    begin
    end; */
    [IntegrationEvent(false, false)]
    local procedure OnCopyPRLine(var NewPurchLine: Record "Purchase Line"; PRPurchLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeModifyRefPRLine(var PRPurchLine: Record "Purchase Line"; NewPurchLine: Record "Purchase Line")
    begin
    end;
}

