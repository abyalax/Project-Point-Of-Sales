// jquery-custom.d.ts
import 'jquery';
import 'jqueryui';

declare global {
  interface JQuery {
    autocomplete(options: AutocompleteOptions): JQuery;
    autocomplete(methodName: string, ...args: any[]): JQuery;
  }

  interface AutocompleteOptions {
    source: (request: AutocompleteRequest, response: AutocompleteResponse) => void;
    minLength?: number;
    select?: (event: Event, ui: AutocompleteItem) => void;
  }

  interface AutocompleteRequest {
    term: string;
  }

  interface AutocompleteResponse {
    (data: any[]): void;
  }

  interface AutocompleteItem {
    item: any;
    [key: string]: any;
  }

  interface JQueryEventObject {
    preventDefault(): void;
    isDefaultPrevented(): boolean;
    // Tambahkan properti lain yang diperlukan
  }
}