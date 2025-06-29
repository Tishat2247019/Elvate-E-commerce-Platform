import {
  Controller,
  Post,
  Get,
  Param,
  Body,
  Put,
  Delete,
  UseGuards,
  Request,
} from '@nestjs/common';
import { CategoryService } from './category.service';
import { CreateCategoryDto } from './dto/create_category.dto';
import { Category } from './entities/category.entity';
import { UpdateCategoryDto } from './dto/update_category.dto';
import { AuthGuard } from '@nestjs/passport';
import { JwtWithBlacklistGuard } from 'src/auth/CustomGuard/jwt_blacklist.guard';

@Controller('category')
export class CategoryController {
  constructor(private readonly categoryService: CategoryService) {}

  @UseGuards(AuthGuard('jwt'))
  @Post()
  async createCategory(
    @Request() req,
    @Body() createCategoryDto: CreateCategoryDto,
  ): Promise<Category> {
    if (req.user.role !== 'admin') {
      throw new Error('Only admin can create categories');
    }
    return this.categoryService.createCategory(createCategoryDto);
  }

  @Get()
  async getCategories() {
    return this.categoryService.getCategories();
  }

  @Get(':id')
  async getCategoryById(@Param('id') id: number) {
    return this.categoryService.getCategoryById(id);
  }

  // @UseGuards(JwtWithBlacklistGuard)
  @Put(':id')
  async updateCategory(
    @Request() req,
    @Param('id') id: number,
    @Body() updateCategoryDto: UpdateCategoryDto,
  ) {
    return this.categoryService.updateCategory(id, updateCategoryDto, req.user);
  }

  @Delete(':id')
  async deleteCategory(@Param('id') id: number) {
    return this.categoryService.deleteCategory(id);
  }
}
