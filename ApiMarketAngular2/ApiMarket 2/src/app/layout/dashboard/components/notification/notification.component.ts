import { Component, OnInit } from '@angular/core';

import  {ApiHome} from '../../.././../class/apiHome';
@Component({
    selector: 'app-notification',
    templateUrl: './notification.component.html',
    styleUrls: ['./notification.component.scss']
})
export class NotificationComponent implements OnInit {
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
