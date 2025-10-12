// import { testPrint } from "../lib/print";
import CartManager from "./core"
import CartUI from "./ui"
// import * as qz from 'qz-tray';

document.addEventListener('DOMContentLoaded', () => {
    const cartManager = new CartManager()
    new CartUI(cartManager)

    /** Connetion web socket QZ Tray  */

    /**
     * test with hardware
    qz.websocket.connect()
    .then(() => {
        console.log("Terhubung ke QZ Tray");
        testPrint();
    })
    .catch(err => {
        console.error("Gagal terhubung", err);
    });
    */


    /**
     * test connection without hardware
     */
    // qz.websocket.connect()
    //     .then(() => alert("Berhasil terhubung ke QZ Tray!"))
    //     .catch(err => alert("Error: " + err.message));
})