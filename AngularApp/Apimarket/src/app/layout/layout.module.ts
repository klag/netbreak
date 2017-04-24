import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
/*import { NgbDropdownModule } from '@ng-bootstrap/ng-bootstrap';*/

import { LayoutRoutingModule } from './layout-routing.module';
import { LayoutComponent } from './layout.component';
import { HeaderComponent} from '../SharedElements/header/header.component';
import { FooterComponent} from '../SharedElements/footer/footer.component';


@NgModule({
    imports: [
        CommonModule,
        /*NgbDropdownModule.forRoot(),*/
        LayoutRoutingModule
    ],
    declarations: [
        LayoutComponent,
        HeaderComponent,
        FooterComponent
    ]
})
export class LayoutModule { }
