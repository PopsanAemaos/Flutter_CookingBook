import mongoose from 'mongoose';

const { Schema } = mongoose;
const {
  ObjectId
} = mongoose.Schema;

const recipe = new Schema({
  // Bank account holder
  title: {
    type: String,
  },
  ingredient: {
    type: Array,
  },
  method: {
    type: Array,
  },
  descripttion: {
    type: String,
  },
  images: {
    type: String,
  },
  updated_at: Date,
  created_at: Date
}, {
  timestamps: true,
  collection: 'recipe'
});

export default mongoose.model('recipe', recipe);

