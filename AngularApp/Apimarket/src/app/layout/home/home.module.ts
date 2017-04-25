import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';


import { HomeRoutingModule } from './home-routing.module';
import { HomeComponent } from './home.component';
import {
    TimelineComponent,
    NotificationComponent,
    ChatComponent
} from './components';


@NgModule({
    imports: [
        CommonModule,
      HomeRoutingModule,
    ],
    declarations: [
      HomeComponent,
        TimelineComponent,
        NotificationComponent,
        ChatComponent
    ]
})
export class HomeModule { }
