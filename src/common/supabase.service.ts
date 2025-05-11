// supabase.service.ts or create-bucket.ts

import * as dotenv from 'dotenv';
dotenv.config(); // ✅ Must come BEFORE accessing process.env

import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.SUPABASE_URL!;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY!;

export const supabase = createClient(supabaseUrl, supabaseKey);
