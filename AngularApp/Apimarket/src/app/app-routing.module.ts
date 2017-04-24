import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

/*
 import {HeaderComponent} from './SharedElements/header/header.component';
 import {FooterComponent} from './SharedElements/footer/footer.component';
*/
import { LayoutComponent } from './layout/layout.component';
import {NotFoundComponent} from './not-found/not-found.component';

const routes: Routes = [
  { path: '', component: LayoutComponent},
  { path: 'not-found', component: NotFoundComponent},
  { path: '**', redirectTo: 'not-found'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

