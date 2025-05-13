// import { Injectable } from '@nestjs/common';
// import { GoogleGenerativeAI } from '@google/generative-ai';

import { GoogleGenerativeAI } from '@google/generative-ai';
import { Injectable } from '@nestjs/common';
import { ProductService } from 'src/product/product.service';

// @Injectable()
// export class GeminiService {
//   private genAI: GoogleGenerativeAI;

//   constructor() {
//     this.genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY!);
//   }

//   async askQuestion(prompt: string): Promise<string> {
//     const model = this.genAI.getGenerativeModel({ model: 'gemini-2.0-flash' });

//     const systemInstruction = `You are a helpful assistant for the Elvate e-commerce website. You help users with ordering, returns, and product questions.If user ask how to,like these type of question, When giving step-by-step instructions, **do not** use Markdown or special formatting.
// Use plain text like:
// 1) Step one
// 2) Step two
// 3) Step three`;

//     const fullPrompt = `${systemInstruction}\n\nUser: ${prompt}`;

//     const result = await model.generateContent(fullPrompt);
//     const response = result.response;

//     return response.text().trim();
//   }
// }

@Injectable()
export class GeminiService {
  private genAI: GoogleGenerativeAI;

  constructor(private readonly productService: ProductService) {
    this.genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY!);
  }

  async askQuestion(prompt: string): Promise<string> {
    const match = prompt.match(/how many.*products?.*named\s+(\w+)/i);
    if (match) {
      const productName = match[1];
      const count = await this.productService.countProductsByName(productName);
      return `We currently have ${count} products related to "${productName}".`;
    }

    const model = this.genAI.getGenerativeModel({ model: 'gemini-2.0-flash' });

    const systemInstruction = `You are a helpful assistant for the Elvate e-commerce website. You help users with ordering, returns, and product questions. When giving step-by-step instructions, do not use Markdown. Use plain text like:
1) Step one
2) Step two`;

    const fullPrompt = `${systemInstruction}\n\nUser: ${prompt}`;

    const result = await model.generateContent(fullPrompt);
    const response = result.response;

    return response.text().trim();
  }
}
