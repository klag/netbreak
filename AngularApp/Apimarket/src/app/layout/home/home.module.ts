import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { HomeRoutingModule } from './home-routing';
import { HomeComponent } from './home.component';
/*
import { HeaderComponent} from '../../SharedElements/header/header.component';
import { FooterComponent} from '../../SharedElements/footer/footer.component';
*/
@NgModule({
  imports: [
    CommonModule,
    HomeRoutingModule
  ],
  declarations: [
    HomeComponent
  ]
})
export class HomeModule {}
