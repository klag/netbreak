import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { UsercpComponent } from './usercp.component';

const routes: Routes = [
    { path: '', component: UsercpComponent }
];

@NgModule({
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})
export class UsercpRoutingModule { }
