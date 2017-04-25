import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { VistaApiHomeComponent } from './vista-api-home.component';

describe('VistaApiHomeComponent', () => {
  let component: VistaApiHomeComponent;
  let fixture: ComponentFixture<VistaApiHomeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ VistaApiHomeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VistaApiHomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
