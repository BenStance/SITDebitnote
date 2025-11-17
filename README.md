# SIT Debit Note (Strategies Insurance)

This folder contains the Debit Note module for the Strategies Insurance solution — a Business Central extension that provides Debit Note pages, lists, posted document handling and a printable RDLC Debit Note report.

The README below explains the folder layout, features, how to install and test the module, and where to change behavior (for example, amount-in-words formatting which includes cents).

## Repository tree (module)

```
Volume serial number is 72B9-4DFD
C:.
│   README.md
│
├───Layout
│       SITDebitNote.rdl
│
├───PageExt
│       Pag-Ext50010.SITExtPurchasePayPg.al
│
├───Pages
│       Pag50011.SITDebitNoteCard.al
│       Pag50012.SITDebitNoteList.al
│       Pag50013.PostedSITDebitNoteCard.al
│       Pag50014.PostedSITDebitNoteList.al
│
├───Report
│       Rep50015.SITDebitNote.al
│
├───TableExt
│       Tab-Ext50002.SITExtPurchasePayable.al
│
└───Tables
	Tab50007.SITDebitNote.al
	Tab50008.PostedSITDebitNote.al
```

## Features

- Debit Note master and posted tables (`Tab50007.SITDebitNote`, `Tab50008.PostedSITDebitNote`).
- Card and list pages for creating, editing and viewing Debit Notes (`Pag50011`, `Pag50012`).
- Posted Debit Note pages (`Pag50013`, `Pag50014`).
- RDLC report `Rep50015.SITDebitNote` for printing debit notes using the `SITDebitNote.rdl` layout.
- Page extension(s) to integrate with purchasing/payment pages as needed (`Pag-Ext50010.SITExtPurchasePayPg`).
- Table extension `Tab-Ext50002.SITExtPurchasePayable` for payable integrations.

## Amount-in-Words behavior

The solution includes a Number-to-Words codeunit used by reports to display amounts in words. It now writes both the whole amount and the cents (for example: "Three thousand shillings and thirty four cents"). If you need to change wording (e.g., currency names like "shillings", "cents", or use "paise" for INR), edit the amount-to-words codeunit in the main project (search for the `Number To Words` or `Amount in Words` codeunit).

Example
- Input: `3000.34`
- Output: "Three thousand shillings and thirty four cents"

## Install / Deploy

1. Open the workspace in Visual Studio Code with the AL Language extension installed.
2. Update `app.json` metadata (id, publisher, version) if needed.
3. Use the Business Central sandbox credentials and launch configuration in `launch.json` (set `server`, `serverInstance`, `tenant`, and `authentication` as required).
4. Press F5 to build and publish the extension to your sandbox. Alternatively, use the `AL: Publish` command.

Notes
- Make sure the target BC version matches the `app.json` compatibility range.
- If you change labels or captions, run a compile and deploy to ensure there are no missing label IDs.

## How to test the Debit Note module

1. In Business Central, search for "SIT Debit Note" (or use the list page) and open the Debit Note list page.
2. Create a new Debit Note using the Card page. Fill mandatory fields and add lines as required.
3. Save and optionally post the Debit Note (posting moves it to the posted table and enables the posted pages).
4. To print, open the Debit Note and choose the Print/Preview action (the RDLC report `Rep50015.SITDebitNote` will use the layout `SITDebitNote.rdl`). The printed report includes the Amount in Words field.

## Customization points

- Report layout: edit `Layout/SITDebitNote.rdl` in Report Builder or Visual Studio to change the printed format.
- Data logic: update `Rep50015.SITDebitNote.al` to change dataset fields delivered to the layout.
- Pages: modify `Pag50011.*` and `Pag50012.*` to change UI or add actions.
- Integrations: `Pag-Ext50010.SITExtPurchasePayPg.al` and `Tab-Ext50002.SITExtPurchasePayable.al` are entry points for linking to Purchasing/Payables.

## Troubleshooting

- If the report fails with a rounding or ROUND parameter error, ensure the Number-to-Words codeunit uses a permitted `Round` step (the AL runtime requires the Round step parameter to be >= 1). The current module uses a safe rounding strategy for cents.
- If the Amount in Words is incorrect or you need truncation instead of rounding, modify the codeunit to use truncation logic (for example, derive the integer part with a truncation method and compute cents separately).

## Contributing

1. Fork the repository and create a feature branch.
2. Implement changes and add tests if appropriate.
3. Raise a pull request with a clear description of the change and testing steps.

## Change log

- 1.0.0 — Initial Debit Note module added (pages, tables, posted pages, RDLC report).

## Contact

For questions about the Strategies Insurance Debit Note module, contact the developer or project owner (see repository metadata).

---

