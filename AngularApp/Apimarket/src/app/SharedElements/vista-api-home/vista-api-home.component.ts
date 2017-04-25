import { Component, OnInit } from '@angular/core';

import  {ApiHome} from '../../apiHome';

@Component({
  selector: 'app-vista-api-home',
  templateUrl: './vista-api-home.component.html',
  styleUrls: ['./vista-api-home.component.css']
})
export class VistaApiHomeComponent implements OnInit {
  api: ApiHome;
  constructor() {
    this.api = {
        nomeApi: 'Api di prova',
        autore: 'pinco pallino',
        prezzo: 20,
        logo: 'www.logo.it'
    };
  }

  ngOnInit() {
  }

}
