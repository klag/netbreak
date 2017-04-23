import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { AppRoutingModule} from './app-routing.module';

import { NotFound } from './not-found.component';


@NgModule({
  declarations: [
    AppComponent,
    NotFound
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule
  ],

  bootstrap: [AppComponent]
})
export class AppModule { }
