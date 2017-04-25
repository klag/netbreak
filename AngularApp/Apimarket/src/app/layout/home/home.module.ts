import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';
import { VistaApiHomeComponent } from '../../SharedElements/vista-api-home/vista-api-home.component';


@NgModule({
    imports: [
        CommonModule,
      HomeRoutingModule,
    ],
    declarations: [
      HomeComponent,
      VistaApiHomeComponent
    ]
})
export class HomeModule { }
