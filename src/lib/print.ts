import * as qz from 'qz-tray';
import { CartState } from '../types/cart';
import { getUserSession } from '../auth';

export async function testPrint() {
    const printers = await qz.printers.find();
    console.log("Printer yang tersedia:", printers);
};

export async function testPrintHTML(carts: CartState): Promise<void> {
    try {
        const now = new Date();
        const dateStr = now.toISOString().split("T")[0];
        const timeStr = now.toTimeString().split(" ")[0];
        const cashier = await getUserSession();
        const html = `
            <div style="font-family: monospace; font-size: 20px; padding: 10px;">
            <div style="text-align: center;">
                <strong>Abya's DevStore</strong><br>
                Jl. Kartini Mojokerep, Plemahan<br>
                Kabupaten Kediri<br>
                No. Telp 0812345678<br>
                16413520230802084636
            </div>
            <hr>
            <div style="display: flex; justify-content: space-between;">
                <div>${dateStr}<br>${timeStr}</div>
                <div style="text-align: end;">
                Kasir<br>
                ${cashier.name}<br>
                </div>
            </div>
            <br>Products<br>
            <hr>
                ${carts.items.map((item, i) => {
                const qty = item.quantity;
                const total = item.price * qty;
                return `
                        <div style="margin-bottom: 15px;">
                        <strong>${i + 1}. ${item.name}</strong>
                        <div style="display:flex;justify-content:space-between;">
                            <div style="margin-left: 30px;">${qty} x Rp ${item.price.toLocaleString("id-ID")}</div>
                            <div>Rp ${total.toLocaleString("id-ID")}</div>
                        </div>
                        </div>
                    `;
                }).join("<br>")}
            <hr>
            <div>Total QTY : ${carts.items.reduce((acc, item) => acc + item.quantity, 0)}</div>
            <br>
            <div style="display: flex; justify-content: space-between;">
                <span>Sub Total</span>
                <span>${carts.subtotal.toLocaleString("id-ID")}</span>
            </div>
            <div style="display: flex; justify-content: space-between;">
                <span>Total Tax</span>
                <span>${carts.tax.toLocaleString("id-ID")}</span>
            </div>
            <div style="display: flex; justify-content: space-between;">
                <span>Total Discount</span>
                <span>${carts.total_discount.toLocaleString("id-ID")}</span>
            </div>
            <div style="display: flex; justify-content: space-between;">
                <strong>Total</strong>
                <strong>${carts.total.toLocaleString("id-ID")}</strong>
            </div>
            <div style="display: flex; justify-content: space-between;">
                <span>Bayar (Cash)</span>
                <span>${carts.pay_received.toLocaleString("id-ID")}</span>
            </div>
            <div style="display: flex; justify-content: space-between;">
                <span>Kembali</span>
                <span>${carts.pay_return.toLocaleString("id-ID")}</span>
            </div>
            <br>
            <div style="text-align: center;">Terimakasih Telah Berbelanja</div>
            <br>
            <div style="font-size: 10px; text-align: center;">
                Link Kritik dan Saran:<br>
                com/e-receipt/S-00D39U-07G344G
            </div>
            </div>
        `;
        console.log(html);
        const config = qz.configs.create("Microsoft Print to PDF", { colorType: "blackwhite" });
        await qz.print(config, [{
            type: 'pixel',
            flavor: 'plain',
            format: 'html',
            data: html
        }]);
        console.log('PDF berhasil dibuat');
    } catch (error) {
        console.error('Gagal membuat PDF:', error);
        throw error;
    }
}

async function testPrintRaw(content: string): Promise<void> {
    try {
        const config = qz.configs.create("POS-58 PANDA V2", { colorType: "blackwhite" });
        await qz.print(config, [{
            type: 'raw',
            flavor: 'plain',
            format: 'command',
            data: content
        }]);
        console.log('Success');
    } catch (error) {
        console.error('Failed: ', error);
        throw error;
    }
}

export async function printStruct(carts: CartState): Promise<void> {
    try {
        // Format tanggal dan data kasir
        const now = new Date();
        const dateStr = now.toISOString().split("T")[0];
        const timeStr = now.toTimeString().split(" ")[0];
        const cashier = await getUserSession();

        // Prepare ESC/POS commands
        const ESC = '\x1B';
        const INIT = `${ESC}@`;
        const BOLD_ON = `${ESC}!${String.fromCharCode(8)}`;
        const BOLD_OFF = `${ESC}!${String.fromCharCode(0)}`;
        const ALIGN_CENTER = `${ESC}a${String.fromCharCode(1)}`;
        const ALIGN_LEFT = `${ESC}a${String.fromCharCode(0)}`;
        const CUT_PAPER = `${ESC}V${String.fromCharCode(65)}${String.fromCharCode(3)}`;
        const LINE_BREAK = '\n';

        // Build receipt content
        let receiptContent = INIT + ALIGN_CENTER + BOLD_ON;

        // Header
        receiptContent += 'Abya\'s DevStore' + LINE_BREAK;
        receiptContent += 'Jl. Kartini Mojokerep, Plemahan' + LINE_BREAK;
        receiptContent += 'Kabupaten Kediri' + LINE_BREAK;
        receiptContent += 'No. Telp 0812345678' + LINE_BREAK;
        receiptContent += '16413520230802084636' + LINE_BREAK + LINE_BREAK;

        receiptContent += ALIGN_LEFT + BOLD_OFF;
        receiptContent += '--------------------------------' + LINE_BREAK;

        // Date and cashier
        receiptContent += `${dateStr} ${timeStr}` + LINE_BREAK;
        receiptContent += `Kasir: ${cashier.name}` + LINE_BREAK + LINE_BREAK;

        // Products header
        receiptContent += 'Products' + LINE_BREAK;
        receiptContent += '--------------------------------' + LINE_BREAK;

        // Products list
        let itemIndex = 1;
        let totalQty = 0;

        carts.items.forEach(item => {
            const qty = item.quantity;
            const total = item.price * qty;
            totalQty += qty;

            receiptContent += `${itemIndex++}. ${item.name}` + LINE_BREAK;
            receiptContent += `   ${qty} x Rp ${item.price.toLocaleString("id-ID")}` + LINE_BREAK;
            receiptContent += `   Rp ${total.toLocaleString("id-ID")}` + LINE_BREAK + LINE_BREAK;
        });

        // Totals
        receiptContent += '--------------------------------' + LINE_BREAK;
        receiptContent += `Total QTY : ${totalQty}` + LINE_BREAK + LINE_BREAK;

        receiptContent += `Sub Total    Rp ${carts.subtotal.toLocaleString("id-ID")}` + LINE_BREAK;
        receiptContent += `Total Tax    Rp ${carts.tax.toLocaleString("id-ID")}` + LINE_BREAK;
        receiptContent += `Discount     Rp ${carts.total_discount.toLocaleString("id-ID")}` + LINE_BREAK;
        receiptContent += BOLD_ON;
        receiptContent += `TOTAL        Rp ${carts.total.toLocaleString("id-ID")}` + LINE_BREAK + LINE_BREAK;
        receiptContent += BOLD_OFF;

        receiptContent += `Bayar (Cash) Rp ${carts.pay_received.toLocaleString("id-ID")}` + LINE_BREAK;
        receiptContent += `Kembali      Rp ${carts.pay_return.toLocaleString("id-ID")}` + LINE_BREAK + LINE_BREAK;

        // Footer
        receiptContent += ALIGN_CENTER;
        receiptContent += 'Terimakasih Telah Berbelanja' + LINE_BREAK + LINE_BREAK;
        receiptContent += 'Link Kritik dan Saran:' + LINE_BREAK;
        receiptContent += 'com/e-receipt/S-00D39U-07G344G' + LINE_BREAK;
        // Paper cut
        receiptContent += CUT_PAPER;
        await testPrintRaw(receiptContent);
        console.log('Receipt printed successfully');
    } catch (error) {
        console.error('Printing failed:', error);
        throw error;
    }
};