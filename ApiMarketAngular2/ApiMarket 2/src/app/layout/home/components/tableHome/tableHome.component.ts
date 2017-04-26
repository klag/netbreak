import { Component, OnInit } from '@angular/core';

import {ApiHome} from '../../.././../class/apiHome';
@Component({
    selector: 'app-notification',
    templateUrl: './tableHome.component.html',
    styleUrls: ['./tableHome.component.scss']
})
export class TableHomeComponent implements OnInit {
    api: ApiHome;
    constructor() {
        this.api = {
            nomeApi: 'Api di prova',
            autore: 'pinco pallino',
            prezzo: 20,
            logo: 'www.logo.it'
        };
    }
    ngOnInit() { }
}
