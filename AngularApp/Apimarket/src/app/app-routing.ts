import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

/*
 import {HeaderComponent} from './SharedElements/header/header.component';
 import {FooterComponent} from './SharedElements/footer/footer.component';
 */
import { HomeComponent } from './home/home.component';
import {NotFoundComponent} from './not-found/not-found.component';

const routes: Routes = [
  { path: '', component: HomeComponent,  pathMatch: 'full' },
  { path: 'home', component: HomeComponent,  pathMatch: 'full' },
  { path: 'not-found', component: NotFoundComponent,  pathMatch: 'full'},
  {path: '**', redirectTo: 'not-found'}
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

