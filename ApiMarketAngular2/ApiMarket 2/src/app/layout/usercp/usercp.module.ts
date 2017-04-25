import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';


import { UsercpRoutingModule } from './usercp-routing.module';
import { UsercpComponent } from './usercp.component';

@NgModule ({
    imports: [
        CommonModule,
        NgbModule.forRoot(),
        UsercpRoutingModule
    ],
    declarations: [
        UsercpComponent
    ]
})
export  class UsercpModule {}
