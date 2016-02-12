<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Post;
use App\Http\Requests;
use App\Http\Controllers\Controller;

class PostsController extends Controller
{
    public function getIndex() {
        $this->dispatch(new \App\Jobs\SendMetricsJob());
        $posts = Post::with(['user', 'tags'])->limit(10)->get();
        return view('posts.index', ['posts' => $posts]);
    }
}
