import { Column } from 'typeorm';

export class ShippingAddress {
  @Column()
  fullName: string;

  @Column()
  street: string;

  @Column()
  city: string;

  @Column()
  state: string;

  @Column()
  postalCode: string;

  @Column()
  country: string;

  @Column()
  phoneNumber: string;
}
