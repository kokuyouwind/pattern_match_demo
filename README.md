Pattern Match Demo
=====

[Burikaigi 2020](https://toyama-eng.connpass.com/event/156635/) で発表するデモのソースコードです。

Rubyパターンマッチの基本的な機能と、[ActivePattern gem](https://github.com/kokuyouwind/active_pattern)及び[MethodMatchable gem](https://github.com/kokuyouwind/method_matchable)の使い方を含みます。

## Usage

標準ではパターンマッチに関する警告が大量にでるので、`-W:no-experimental`オプションを付けて実行するのが望ましいです。

```bash
$ bundle install

$ bundle exec ruby -W:no-experimental src/01_array.rb
# or
$ export RUBYOPT=-W:no-experimental
$ bundle exec ruby src/01_array.rb
```
