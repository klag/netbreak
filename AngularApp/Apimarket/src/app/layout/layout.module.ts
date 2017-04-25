import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { LayoutRoutingModule } from './layout-routing.module';
import { LayoutComponent } from './layout.component';
import { FooterComponent} from '../SharedElements/footer/footer.component';
import { HeaderComponent} from '../SharedElements/header/header.component';

import { HomeComponent } from './home/home.component';



@NgModule({
    imports: [
        CommonModule,
        LayoutRoutingModule
    ],
    declarations: [
        LayoutComponent,
        HeaderComponent,
        FooterComponent,
        HomeComponent
    ]
})
export class LayoutModule { }
