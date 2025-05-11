// scripts/create-bucket.ts
import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';

dotenv.config(); // load .env variables

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
);

async function createBucket() {
  const { error } = await supabase.storage.createBucket('product-images', {
    public: true,
  });

  if (error) {
    console.error('❌ Bucket creation failed:', error.message);
  } else {
    console.log('✅ Bucket "product-images" created successfully.');
  }
}

createBucket();
