<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Post;
use App\Http\Requests;
use App\Http\Controllers\Controller;

class PostsController extends Controller
{
    public function getIndex() {
        $posts = Post::with(['tags', 'user'])->limit(30)->get();
        return view('posts.index', ['posts' => $posts]);
    }

    public function getFromTags($tag) {
        $posts = Post::with(['tags', 'user'])->whereHas('tags', function($query) use ($tag) {
            $query->where('name', $tag);
        })->get();
        return view('posts.index', ['posts' => $posts]);
    }
}
