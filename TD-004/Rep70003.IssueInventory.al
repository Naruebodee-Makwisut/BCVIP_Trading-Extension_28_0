report 70003 "AVTD_Issue Inventory"
{
    // version AVTHLC1.0
    //AVTMGVIP.001 30/10/2019 Add Code Get Serial Lot
    //AVTMGVIP.002 30/10/2019 Add Code Check Decimal Quantity

    DefaultLayout = RDLC;
    RDLCLayout = 'TD-004/Rdlc/Issue Inventory.rdl';
    PreviewMode = PrintLayout;
    Caption = 'Issue Inventory';

    dataset
    {
        dataitem("Issue Header"; "AVTD_Issue Header")
        {
            DataItemTableView = sorting("Issue No.");
            RequestFilterFields = "Issue No.";
            column(ReportName; ReportName)
            {
            }
            column(ReportNameTH; ReportNameth)
            {
            }
            column(USERID; UserId())
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name + ' ' + CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPhone; 'โทร : ' + CompanyInfo."Phone No." + ' แฟกซ์ : ' + CompanyInfo."Fax No.")
            {
            }
            column(CompanyVAT; 'เลขประจำตัวผู้เสียภาษี : ' + CompanyInfo."VAT Registration No.")
            {
            }
            column(ShowInternalInfo; ShowInternalInfo)
            {
            }
            column(SHOWSN; SHOWSN)
            {
            }
            column(RunningNum; RunningNum)
            {
            }
            column(Line; Line)
            {
            }
            column(MaxLine; MaxLine)
            {
            }
            column(AddLine; AddLine)
            {
            }
            column(DatePrinted; FORMAT(Today(), 0, '<Day,2>/<Month,2>/<Year4>') + ' ' + Format(Time(), 0, '<Hours12>:<Minutes,2>:<Seconds,2> <AM/PM>'))
            {
            }
            column(ShortcutDimension1Code_IssueHeader; "Issue Header"."Shortcut Dimension 1 Code")
            {
            }
            column(RequestedBy_IssueHeader; AVSalespersonTB.Name)
            {
            }
            column(REMARK_IssueHeader; "Issue Header".Remark + ' ' + "Issue Header"."Remark 2")
            {
            }
            column(IssueNo_IssueHeader; "Issue Header"."Issue No.")
            {
            }
            column(PostingDate_IssueHeader; format("Issue Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Issue No.");
                DataItemLinkReference = "Issue Header";
                DataItemTableView = SORTING("Item No.", "Posting Date");
                column(Running; Running)
                {
                }
                column(LineShow; LineShow)
                {
                }
                column(ItemNo_ItemJournalLine; "Item No.")
                {
                }
                column(Description_ItemJournalLine; Description)
                {
                }
                column(Quantity_ItemJournalLine; Quantity)
                {
                }
                column(QtyText; QtyText)
                {
                }
                column(UnitofMeasureCode_ItemJournalLine; "Unit of Measure Code")
                {
                }
                column(AVSerialLot; AVSerialLot)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Running += 1;
                    LineShow += 1;
                    /*if ("Item No." <> '') then begin
                        //Line += 1;
                        //LineShow := Line;
                        LineShow += 1;
                    end
                    else
                        LineShow := 0;*/

                    //AVTMGVIP.001 30/10/2019 Add Code Get Serial Lot
                    Clear(AVSerialLot);
                    if "Lot No." <> '' then
                        AVSerialLot := 'LOT No. : ' + "Lot No.";

                    if "Serial No." <> '' then
                        if AVSerialLot <> '' then
                            AVSerialLot += ', Serial No. : ' + "Serial No."
                        else
                            AVSerialLot := 'Serial No. : ' + "Serial No.";

                    if AVSerialLot <> '' then begin
                        Running += 1;
                        Line += 1;
                    end;

                    //C-AVTMGVIP.001 30/10/2019 Add Code Get Serial Lot

                    //AVTMGVIP.002 30/10/2019 Add Code Check Decimal Quantity
                    Clear(QtyText);
                    if "Item Ledger Entry".Quantity mod 1 = 0 then
                        QtyText := Format("Item Ledger Entry".Quantity)
                    else
                        QtyText := Format("Item Ledger Entry".Quantity, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                    //C-AVTMGVIP.002 30/10/2019 Add Code Check Decimal Quantity
                end;

                trigger OnPreDataItem();
                begin
                    Line := Count();
                    //LineShow := 0;
                end;
            }
            dataitem("Empty Line"; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(Number_EmptyLine; "Empty Line".Number)
                {
                }

                trigger OnPreDataItem();
                begin
                    if (Line = Running) and (Running <> MaxLine) then begin
                        if (Line mod MaxLine = 0) then
                            SETRANGE(Number, 1, 0)
                        else begin
                            AddLine := MaxLine - (Line mod MaxLine);
                            SETRANGE(Number, 1, AddLine);
                        end;
                    end else
                        SETRANGE(Number, 1, 0);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(ReportName);
                ReportName := 'Adjust Inventory';
                ReportNameth := 'ใบปรับปรุงสินค้า';

                //AVTMGVIP 31/10/2019 Add Code Clear Running No. On New Doc
                Clear(Running);
                Clear(Line);
                Clear(LineShow);
                //C-AVTMGVIP 31/10/2019 Add Code Clear Running No. On New Doc

                //AVTMGVIP 31/10/2019 Add Code Get Salesperson Name
                Clear(AVSalespersonTB);
                if AVSalespersonTB.Get("Requested By") then;
                //C-AVTMGVIP 31/10/2019 Add Code Get Salesperson Name
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
                Clear(MaxLine);
                MaxLine := 26;
                ComIs := false;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("สำเนาเอกสาร")
                {
                    Caption = 'สำเนาเอกสาร';
                    Visible = false;
                    field("No_Of_Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. Of Copies';
                    }
                    field("Show_Internal_Info"; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Internal Information';
                    }
                    field("SHOW_SN"; SHOWSN)
                    {
                        ApplicationArea = All;
                        Caption = 'SHOW SERIAL NO.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        AVSalespersonTB: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        Running: Integer;
        Line: Integer;
        MaxLine: Integer;
        AddLine: Integer;
        NoOfCopies: Integer;
        LineShow: Integer;
        ShowInternalInfo: Boolean;
        SHOWSN: Boolean;
        RunningNum: Integer;
        ReportName: Text[100];
        ReportNameth: Text[100];
        AVSerialLot: Text[150];
        QtyText: Text[10];
        ComIs: Boolean;
    /* NoOfLoops: Integer;
    DimensionSetEntryH: Record "Dimension Set Entry";
    DimensionSetEntryL: Record "Dimension Set Entry";
    DimTextH: Text[120];
    DimTextL: Text[120];
    Text: array[20] of Text[200];
    CopyText: Text[30];
    FormatAddr: Codeunit "Format Address";
    TransferFromAddr: array[8] of Text[50];
    TransferToAddr: array[8] of Text[50];
    ShipmentMethod: Record "Shipment Method"; */
}

