import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

import { NotFound } from './not-found.component';
import {HeroListComponent} from './user/user.component';

const appRoutes: Routes = [
  {path: '', component: HeroListComponent },
  { path: 'not-found', component: NotFound },
  { path: '**', redirectTo: 'not-found' }
];

@NgModule({
    imports: [
      RouterModule.forRoot(appRoutes)
    ],
    exports: [
      RouterModule
    ]
})
export class AppRoutingModule { }
