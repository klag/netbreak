import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';


import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';
import {
    TableHomeComponent,
    SearchComponent
} from './components';
import { StatModule } from '../../shared';

@NgModule({
    imports: [
        CommonModule,
        NgbModule.forRoot(),
        HomeRoutingModule,
        StatModule,
    ],
    declarations: [
        HomeComponent,
        TableHomeComponent,
        SearchComponent,
    ]
})
export class HomeModule { }
