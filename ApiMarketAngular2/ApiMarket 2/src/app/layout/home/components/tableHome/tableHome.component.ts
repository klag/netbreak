import { Component, OnInit } from '@angular/core';

import {ApiHome} from '../../.././../class/apiHome';
@Component({
    selector: 'app-notification',
    templateUrl: './tableHome.component.html',
    styleUrls: ['./tableHome.component.scss']
})
export class TableHomeComponent implements OnInit {

    apis = [
        new ApiHome('photoshop', 'adobe1', 500, 'www.photoshop.it'),
        new ApiHome('illustrator', 'adobe2', 600, 'www.illustrator.it')
    ];

    /*constructor() {
        this.api = ({
            nomeApi: 'Api di prova',
            autore: 'pinco pallino',
            prezzo: 20,
            logo: 'www.logo.it',
        }, {
            nomeApi: 'Api di prova',
            autore: 'pinco pallino',
            prezzo: 20,
            logo: 'www.logo.it'
        });
    }*/
    ngOnInit() { }
}
