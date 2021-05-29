import mongoose from 'mongoose';

const { Schema } = mongoose;
const {
  ObjectId
} = mongoose.Schema;

const favorite = new Schema({
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
  user_id: {
    type: String,
    ref: 'user'
  },
  updated_at: Date,
  created_at: Date
}, {
  timestamps: true,
  collection: 'favorite'
});

export default mongoose.model('favorite', favorite);

