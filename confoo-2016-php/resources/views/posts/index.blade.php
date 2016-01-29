<h1>Posts</h1>

@foreach ($posts as $post)
  <p>{{ $post->title }}</p>
    There are {{ $post->comments->count() }} comments
@endforeach
